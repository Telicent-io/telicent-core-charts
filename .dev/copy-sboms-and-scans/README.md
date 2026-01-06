# copy-sboms-and-scans

A small utility that collects SBOM and vulnerability reports for images used by the `telicent-core` Helm chart and copies them to an S3 deliveries bucket under a customer-specific prefix.

Usage

- Install dependencies: `pip install boto3 PyYAML pytest kubernetes`

- Run locally (example):

  ```bash
  export COPY_SBOMS_S3_BUCKET=my-bucket
  export DEFAULT_AWS_REGION=eu-west-1
  python -m .dev.copy_sboms_and_scans.main --customer test
  ```

Behavior

- Reads `charts/telicent-core/Chart.yaml` to get version (used as `v{version}` in S3 prefix).
- Collects images from `charts/telicent-core` and its dependent charts using values.yaml `.image.registry` and `.image.repository` and Chart.yaml `.appVersion`.
- Uses `kubectl` (current context) to fetch `sbomreports` and `vulnerabilityreports` across the cluster.
- Selects the latest resource for each matching image (by creationTimestamp).
- Removes any objects under the S3 prefix `{customer}/v{version}-{YYYY-MM-DD}/images/SBOM` and uploads new JSON files `{registry}/{repository}-{tag}.json`.

Testing

- Tests are in `tests/test_main.py` and use `pytest` with monkeypatching of `kubectl` and `boto3.client`.

Notes

- The script uses the configured `kubectl` context and the standard AWS credential mechanism (env vars, shared config, role, etc.).
- If you need to adapt the code to a specific custom resource group/version for the SBOM / vulnerability CRDs (if `kubectl get` fails), adjust the logic in `kubectl_get_all`.
