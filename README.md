# Telicent CORE Helm Charts

This repository contains Helm charts for deploying the Telicent CORE platform and its components.

## Installation

To install the Telicent CORE Helm chart, use the following commands:

```sh
helm repo add --username <GithubUsername> --password <GithubPAT*> telicent-core-charts 'https://raw.githubusercontent.com/Telicent-io/telicent-core-charts/gh-pages'
helm repo update
helm search repo telicent-charts
helm install my-release telicent-core --values <path-to-your-values-file.yaml>
```

Replace `my-release` with your desired release name.

\*For details [see here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) (PAT must have read access to this repo)

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

## Available Charts

### Main Charts

- **[telicent-core](./charts/telicent-core/README.md)** - The main Telicent CORE platform chart
- **[telicent-pipelines](./charts/telicent-pipelines/README.md)** - Telicent data processing pipelines

### Core Components

The `telicent-core` chart includes the following sub-charts:

- **[access](charts/telicent-core/charts/access/README.md)** - Access control service
- **[access-ui](./charts/telicent-core/charts/access-ui/README.md)** - Access control user interface
- **[graph-ui](./charts/telicent-core/charts/graph-ui/README.md)** - Graph visualization interface
- **[query-ui](./charts/telicent-core/charts/query-ui/README.md)** - Query interface for data exploration
- **[search-ui](./charts/telicent-core/charts/search-ui/README.md)** - Search interface
- **[graph](charts/telicent-core/charts/graph/README.md)** - Graph data caching service
- **[search](charts/telicent-core/charts/search/README.md)** - Search data caching service
- **[search-projector](charts/telicent-core/charts/search-projector/README.md)** - Search projector/indexer service
- **[user-preferences](charts/telicent-core/charts/user-preferences/README.md)** - User preferences management API

### Demo Prerequisites

The following charts provide demo environment prerequisites:

- **demo-prereqs-gateways** - Gateway configurations for demo environments
- **demo-prereqs-kafka** - Kafka setup for demo environments
- **demo-prereqs-keycloak** - Keycloak authentication for demo environments
- **demo-prereqs-mongodb** - MongoDB database for demo environments
- **demo-prereqs-oauth2-proxy** - OAuth2 proxy for demo environments
- **demo-prereqs-system-mesh** - Service mesh configuration for demo environments

## Configuration

For detailed configuration options and values, please refer to the individual chart READMEs linked above. Each chart has its own set of configurable values and deployment options.

To customize the values, create a `values.yaml` file and override the default values as needed:

```bash
helm install my-release ./telicent-core -f values.yaml
```

## Getting Started

1. Choose the appropriate chart for your needs (typically `telicent-core` for a full platform deployment)
2. Review the chart-specific README for configuration options
3. Create your custom `values.yaml` file
4. Install using the Helm commands above

For more detailed information about each component, please consult the individual chart documentation.

## License

Copyright &copy; 2025 Telicent Limited
