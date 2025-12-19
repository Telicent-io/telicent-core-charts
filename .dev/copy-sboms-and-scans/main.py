"""Copy SBOMs and vulnerability reports for telicent-core images to an S3 bucket.

Usage:
    python -m .dev.copy_sboms_and_scans.main --customer test --bucket my-bucket --region us-east-1

Defaults:
    customer: 'test'
    bucket: from env COPY_SBOMS_S3_BUCKET
    region: from env DEFAULT_AWS_REGION
"""
from __future__ import annotations

import argparse
import datetime
import json
import os
import re
from typing import Dict, Iterable, List, Optional, Set, Tuple

import boto3
import yaml
try:
    from kubernetes import config as k8s_config, client as k8s_client
    from kubernetes.client.rest import ApiException as k8s_ApiException
except Exception:
    # allow tests or environments without the kubernetes package to import the module
    class _Dummy:  # simple placeholder object with settable attributes
        pass

    k8s_config = _Dummy()
    k8s_client = _Dummy()
    dynamic = _Dummy()

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
TC_CORE_CHART = os.path.join(ROOT, "charts", "telicent-core")


def read_chart_version(chart_dir: str = TC_CORE_CHART) -> str:
    chart_yaml = os.path.join(chart_dir, "Chart.yaml")
    with open(chart_yaml, "r", encoding="utf-8") as fh:
        data = yaml.safe_load(fh)
    return str(data.get("version", ""))


def gather_chart_images(chart_dir: str = TC_CORE_CHART) -> Set[str]:
    """Collect images from a chart and its child charts.

    Image format: {registry}/{repository}:{tag}
    registry: .image.registry from values.yaml
    repository: .image.repository from values.yaml
    tag: .appVersion from Chart.yaml
    """
    images: Set[str] = set()

    # helper to read values and chart
    def read_chart_and_values(path: str) -> Optional[Tuple[dict, dict]]:
        chart_yaml = os.path.join(path, "Chart.yaml")
        values_yaml = os.path.join(path, "values.yaml")
        if not os.path.exists(chart_yaml) or not os.path.exists(values_yaml):
            return None
        with open(chart_yaml, "r", encoding="utf-8") as ch, open(values_yaml, "r", encoding="utf-8") as vh:
            chart = yaml.safe_load(ch)
            values = yaml.safe_load(vh)
        return chart or {}, values or {}

    # root chart
    root = read_chart_and_values(chart_dir)
    if root:
        chart, values = root
        reg = (values.get("image") or {}).get("registry")
        repo = (values.get("image") or {}).get("repository")
        tag = chart.get("appVersion")
        if reg and repo and tag:
            images.add(f"{reg}/{repo}:{tag}")

    # dependent charts under charts/
    charts_dir = os.path.join(chart_dir, "charts")
    if os.path.isdir(charts_dir):
        for name in os.listdir(charts_dir):
            cdir = os.path.join(charts_dir, name)
            cv = read_chart_and_values(cdir)
            if not cv:
                continue
            chart, values = cv
            reg = (values.get("image") or {}).get("registry")
            repo = (values.get("image") or {}).get("repository")
            tag = chart.get("appVersion")
            if reg and repo and tag:
                images.add(f"{reg}/{repo}:{tag}")
    return images


def load_kube_config():
    """Load kubeconfig from standard locations."""
    try:
        k8s_config.load_incluster_config()
    except Exception:
        k8s_config.load_kube_config()


def get_kubectl_objects(resource_name: str, group: str = 'aquasecurity.github.io', version: str = 'v1alpha1') -> dict:
    """Fetch all Trivy CR objects for 'resource_name' using the dynamic Kubernetes client."""
    api = k8s_client.CustomObjectsApi()
    try:
        result = api.list_cluster_custom_object(
            group=group,
            version=version,
            plural=resource_name,
        )
        return result
    except k8s_ApiException as e:
        raise RuntimeError(
            f'Failed to list {resource_name} ({group}/{version}): {e.reason}'
        )


def _parse_image_from_object(obj: dict) -> Optional[str]:
    try:
        report = obj.get("report", {})
        reg = (report.get("registry") or {}).get("server") if isinstance(report.get("registry"), dict) else None
        # fallback to .report.registry.server if nested differently
        if not reg:
            reg = report.get("registry", {}).get("server") if isinstance(report.get("registry"), dict) else None
        repo = report.get("artifact", {}).get("repository")
        tag = report.get("artifact", {}).get("tag")
        if reg and repo and tag:
            return f"{reg}/{repo}:{tag}"
    except Exception:
        return None
    return None


def select_latest_matching(items: Iterable[dict], images: Set[str]) -> Dict[str, dict]:
    """Select latest item for each image in images set.

    Return mapping image -> object (latest by metadata.creationTimestamp)
    """
    candidates: Dict[str, dict] = {}

    def to_dt(s: str) -> datetime.datetime:
        try:
            if s.endswith("Z"):
                s = s.rstrip("Z")
                return datetime.datetime.fromisoformat(s).replace(tzinfo=datetime.timezone.utc)
            return datetime.datetime.fromisoformat(s)
        except Exception:
            return datetime.datetime.fromtimestamp(0, tz=datetime.timezone.utc)

    for it in items:
        image = _parse_image_from_object(it.get("report", {}) and it or it)
        if not image or image not in images:
            continue
        ts = it.get("metadata", {}).get("creationTimestamp")
        if not ts:
            ts_dt = datetime.datetime.fromtimestamp(0, tz=datetime.timezone.utc)
        else:
            ts_dt = to_dt(ts)
        existing = candidates.get(image)
        if existing:
            existing_ts = existing.get("metadata", {}).get("creationTimestamp")
            existing_dt = to_dt(existing_ts) if existing_ts else datetime.datetime.fromtimestamp(0, tz=datetime.timezone.utc)
            if ts_dt > existing_dt:
                candidates[image] = it
        else:
            candidates[image] = it
    return candidates


def s3_delete_version_images(s3_client, bucket: str, prefix: str, customer: str, version: str) -> None:
    paginator = s3_client.get_paginator("list_objects_v2")
    to_delete = []
    for page in paginator.paginate(Bucket=bucket, Prefix=prefix):
        for obj in page.get("Contents", []):
            if re.match(f"^{customer}/v{version}", obj["Key"]):
                to_delete.append({"Key": obj["Key"]})
    if to_delete:
        # chunk deletes (max 1000 per request)
        for i in range(0, len(to_delete), 1000):
            s3_client.delete_objects(Bucket=bucket, Delete={"Objects": to_delete[i : i + 1000]})


def s3_put_json(s3_client, bucket: str, key: str, body: object) -> None:
    data = json.dumps(body, ensure_ascii=False, indent=None)
    s3_client.put_object(Bucket=bucket, Key=key, Body=data.encode("utf-8"), ContentType="application/json")


def process(customer: str, bucket: str, region: str, chart_dir: str = TC_CORE_CHART):
    tc_core_version = read_chart_version(chart_dir)
    tc_core_images = gather_chart_images(chart_dir)

    # Kubernetes: get resources
    load_kube_config()
    sbom_objs = get_kubectl_objects("sbomreports").get("items", [])
    vuln_objs = get_kubectl_objects("vulnerabilityreports").get("items", [])

    sbom_matches = select_latest_matching(sbom_objs, tc_core_images)
    vuln_matches = select_latest_matching(vuln_objs, tc_core_images)

    # AWS S3
    s3 = boto3.client("s3", region_name=region) if region else boto3.client("s3")

    today = datetime.date.today().isoformat()
    prefix = f"{customer}/v{tc_core_version}-{today}/images/SBOM"

    # clean prefix
    s3_delete_version_images(s3, bucket, prefix, customer, tc_core_version)

    # Upload SBOMs
    for image, obj in sbom_matches.items():
        # parse registry/repo/tag
        reg_repo, tag = image.rsplit(":", 1)
        registry, repository = reg_repo.split("/", 1)
        key = f"{prefix}/{registry}/{repository}-{tag}/image-SBOM.json"
        components = obj.get("report", {}).get("components", [])
        s3_put_json(s3, bucket, key, components)

    # Upload vulnerability reports (store .report)
    for image, obj in vuln_matches.items():
        reg_repo, tag = image.rsplit(":", 1)
        registry, repository = reg_repo.split("/", 1)
        key = f"{prefix}/{registry}/{repository}-{tag}/image-trivy-report.json"
        report = obj.get("report", {})
        s3_put_json(s3, bucket, key, report)


def parse_args(argv: Optional[List[str]] = None) -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Copy SBOMs and vulnerability reports to an S3 bucket")
    p.add_argument("--customer", default=os.getenv("COPY_SBOMS_CUSTOMER", "test"), help="Comma-separated customers")
    p.add_argument("--bucket", default=os.getenv("COPY_SBOMS_S3_BUCKET"), help="S3 bucket name")
    p.add_argument("--region", default=os.getenv("DEFAULT_AWS_REGION"), help="AWS region")
    return p.parse_args(argv)


def main(argv: Optional[List[str]] = None):
    args = parse_args(argv)
    if not args.bucket:
        raise SystemExit("S3 bucket must be provided either via --bucket or COPY_SBOMS_S3_BUCKET env var")
    for cust in [c.strip() for c in args.customer.split(",") if c.strip()]:
        process(cust, args.bucket, args.region)


if __name__ == "__main__":
    main()
