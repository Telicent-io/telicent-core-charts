import json
import os
import subprocess
from datetime import datetime, timezone

import boto3
import pytest

from . import main as cs


def test_read_chart_version(tmp_path, monkeypatch):
    chart_dir = tmp_path / "chart"
    chart_dir.mkdir()
    (chart_dir / "Chart.yaml").write_text("version: 1.2.3\nappVersion: v1\n")
    (chart_dir / "values.yaml").write_text("image:\n  registry: reg.io\n  repository: repo\n")
    ver = cs.read_chart_version(str(chart_dir))
    assert ver == "1.2.3"


def test_gather_chart_images_with_children(tmp_path):
    chart_dir = tmp_path / "chart"
    chart_dir.mkdir()
    (chart_dir / "Chart.yaml").write_text("version: 0.1\nappVersion: 0.2\n")
    (chart_dir / "values.yaml").write_text("image:\n  registry: reg\n  repository: repo-root\n")
    charts_dir = chart_dir / "charts"
    charts_dir.mkdir()
    child = charts_dir / "child"
    child.mkdir()
    (child / "Chart.yaml").write_text("version: 0.1\nappVersion: 0.9\n")
    (child / "values.yaml").write_text("image:\n  registry: reg2\n  repository: repo-child\n")

    images = cs.gather_chart_images(str(chart_dir))
    assert "reg/repo-root:0.2" in images
    assert "reg2/repo-child:0.9" in images


def test_select_latest_matching():
    images = {"reg/repo:1.0"}
    older = {"metadata": {"creationTimestamp": "2020-01-01T00:00:00Z"}, "report": {"registry": {"server": "reg"}, "artifact": {"repository": "repo", "tag": "1.0"}}}
    newer = {"metadata": {"creationTimestamp": "2021-01-01T00:00:00Z"}, "report": {"registry": {"server": "reg"}, "artifact": {"repository": "repo", "tag": "1.0"}}}
    selected = cs.select_latest_matching([older, newer], images)
    assert "reg/repo:1.0" in selected
    assert selected["reg/repo:1.0"]["metadata"]["creationTimestamp"] == "2021-01-01T00:00:00Z"


class DummyProc:
    def __init__(self, out):
        self.stdout = out


def test_kubectl_get_all(monkeypatch):
    data = {"items": [{"metadata": {"name": "a"}}]}

    def fake_run(*args, **kwargs):
        return DummyProc(json.dumps(data))

    monkeypatch.setattr(subprocess, "run", fake_run)
    out = cs.kubectl_get_all("sbomreports")
    assert isinstance(out, dict)
    assert out["items"][0]["metadata"]["name"] == "a"


def test_s3_upload_and_delete(monkeypatch):
    calls = {}

    class DummyS3:
        def __init__(self):
            self.objects = {}

        def get_paginator(self, name):
            class P:
                def __init__(self, items):
                    self.items = items

                def paginate(self, Bucket, Prefix):
                    # pretend there are two objects
                    yield {"Contents": [{"Key": f"{Prefix}/old1.json"}, {"Key": f"{Prefix}/old2.json"}]}

            return P(None)

        def delete_objects(self, Bucket, Delete):
            calls['del'] = Delete

        def put_object(self, Bucket, Key, Body, ContentType="application/json"):
            calls.setdefault('puts', []).append({'Bucket': Bucket, 'Key': Key, 'Body': Body})

    s3 = DummyS3()
    cs.s3_delete_prefix(s3, "bucket", "prefix")
    assert 'del' in calls
    cs.s3_put_json(s3, "bucket", "k.json", {"a": 1})
    assert calls['puts'][0]['Key'] == 'k.json'


def test_process_integration(monkeypatch, tmp_path):
    # Setup chart
    chart_dir = tmp_path / "charts" / "telicent-core"
    chart_dir.mkdir(parents=True)
    (chart_dir / "Chart.yaml").write_text("version: 9.9.9\nappVersion: 9.9\n")
    (chart_dir / "values.yaml").write_text("image:\n  registry: reg\n  repository: repo\n")

    # Fake kubectl output with one sbom and one vuln
    sbom_item = {"metadata": {"creationTimestamp": "2022-01-01T00:00:00Z"}, "report": {"registry": {"server": "reg"}, "artifact": {"repository": "repo", "tag": "9.9"}, "components": [{"name": "c"}]}}
    vuln_item = {"metadata": {"creationTimestamp": "2022-01-02T00:00:00Z"}, "report": {"registry": {"server": "reg"}, "artifact": {"repository": "repo", "tag": "9.9"}, "vulns": [{"id": "V-1"}]}}

    class FakeResObj:
        def __init__(self, data):
            self._data = data

        def to_dict(self):
            return self._data

    class FakeResource:
        def __init__(self, name, data):
            self.name = name
            self._data = data

        def get(self):
            return FakeResObj(self._data)

    class FakeDynamic:
        def __init__(self, resources):
            self.resources = resources

    fake_sbom = FakeResource("sbomreports", {"items": [sbom_item]})
    fake_vuln = FakeResource("vulnerabilityreports", {"items": [vuln_item]})
    monkeypatch.setattr(cs.k8s_config, "load_kube_config", lambda: None)
    monkeypatch.setattr(cs.k8s_config, "load_incluster_config", lambda: None)
    monkeypatch.setattr(cs.dynamic, "DynamicClient", lambda *a, **k: FakeDynamic([fake_sbom, fake_vuln]))

    # Fake s3
    ops = []

    class FakeS3:
        def __init__(self):
            pass

        def get_paginator(self, name):
            class P:
                def paginate(self, Bucket, Prefix):
                    yield {"Contents": []}

            return P()

        def delete_objects(self, Bucket, Delete):
            ops.append(("del", Bucket, Delete))

        def put_object(self, Bucket, Key, Body, ContentType="application/json"):
            ops.append(("put", Bucket, Key, Body))

    monkeypatch.setattr(boto3, "client", lambda *a, **k: FakeS3())

    cs.process("test", "bucket-name", "eu-west-1", chart_dir=str(chart_dir))

    # Should have put two objects (one for sbom, one for vuln)
    put_calls = [o for o in ops if o[0] == 'put']
    assert len(put_calls) == 2
    keys = {c[2] for c in put_calls}
    assert any('reg/repo-9.9.json' in k for k in keys)
