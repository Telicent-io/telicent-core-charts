# Telicent CORE Helm

## Installation

To install the Telicent CORE Helm chart, use the following commands:

```sh
helm repo add --username <GithubUsername> --password <GithubPAT*> telicent-core-charts 'https://raw.githubusercontent.com/Telicent-io/telicent-core-charts/gh-pages'
helm repo update
helm search repo telicent-charts
helm install my-release telicent-core --values <path-to-your-values-file.yaml>
```

Replace `my-release` with your desired release name.

## Upgrading

To upgrade an existing release:

```sh
helm upgrade my-release telicent/core
```

## Uninstalling

To uninstall the chart:

```sh
helm uninstall my-release
```

For more configuration options, see the [values.yaml](./values.yaml) file.

\*For details [see here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) (PAT must have read access to this repo)
