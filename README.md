# Telicent CORE Helm Charts

This repository contains Helm charts for deploying the Telicent CORE platform and its components.

## Installation

To install the Telicent CORE Helm chart, use the following commands:

```sh
helm repo add telicent-core-charts 'https://charts.telicent.io'
helm repo update
helm search repo telicent-core-charts
helm install my-release telicent-core --values <path-to-your-values-file.yaml>
```

Replace `my-release` with your desired release name.

## Upgrading

To upgrade an existing release:

```sh
helm upgrade my-release 
```

## Uninstalling

To uninstall the chart:

```sh
helm uninstall my-release
```

## Available Charts

### Main Charts

- **[telicent-CORE](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-core/README.md)** - The main Telicent CORE platform chart.
- **[telicent-DATA](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-data/README.md)** -  Supplementary Chart to provide some pre-made Producers.
- **[telicent-PREVIEW](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-preview/README.md)** - Secondary chart with items still under active development.

### Core Components

The `telicent-core` chart includes the following sub-charts:

- **[admin-ui](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-core/charts/admin-ui/README.md)** - Administration user interface
- **[auth](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-core/charts/auth/README.md)** - Auth service
- **[graph-ui](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-core/charts/graph-ui/README.md)** - Graph visualization interface
- **[query-ui](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-core/charts/query-ui/README.md)** - Query interface for data exploration
- **[search-ui](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-core/charts/search-ui/README.md)** - Search interface
- **[graph](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-core/charts/graph/README.md)** - Graph data caching service
- **[search](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-core/charts/search/README.md)** - Search data caching service
- **[search-projector](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-core/charts/search-projector/README.md)** - Search projector/indexer service
- **[user-preferences](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-core/charts/user-preferences/README.md)** - User preferences management API

### Data Components

#### ACLED

- **[acled-locations-mapper](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-data/charts/acled-locations-mapper/README.md)** - ACLED Locations mapper
- **[acled-participants-mapper](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-data/charts/acled-participants-mapper/README.md)** - ACLED Participants mapper
- **[acled-validation-mapper](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-data/charts/acled-validation-mapper/README.md)** - ACLED Validation mapper
- **[producer-acled-ontology](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-data/charts/producer-acled-ontology/README.md)** - ACLED Ontology Producer

#### Canonical Event

- **[canonicals-event-knowledge-mapper](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-data/charts/canonicals-event-knowledge-mapper/README.md)** - Canonicals Event Knowledge Mapper
- **[canonicals-event-validation-mapper](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-data/charts/canonicals-event-validation-mapper/README.md)** - Canonicals Event Validation Mapper
- **[ies-regions-producer](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-data/charts/ies-regions-producer/README.md)** - IES Regions Producer
- **[canonicals-event-document-mapper](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-data/charts/canonicals-event-document-mapper/README.md)** - Canonicals Event Document Mapper
- **[canonicals-event-geo-mapper](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-data/charts/canonicals-event-geo-mapper/README.md)** - Canonicals Event Geo Mapper

#### IES / RDF

- **[ies-regions-ontology-adapter](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-data/charts/ies-regions-ontology-adapter/README.md)** - IES Regions Ontology Adapter
- **[ies-ontology-producer](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-data/charts/ies-ontology-producer/README.md)** - IES Ontology Producer
- **[ontologies-rdf-rdfs-owl-producer](https://github.com/Telicent-io/telicent-core-charts/blob/main/charts/telicent-data/charts/ontologies-rdf-rdfs-owl-producer/README.md)** - Ontologies RDF RDFS Owl Producer

### Demo Prerequisites

The following charts provide demo environment prerequisites:

- **demo-prereqs-gateways** - Gateway configurations for demo environments
- **demo-prereqs-kafka** - Kafka setup for demo environments
- **demo-prereqs-keycloak** - Keycloak authentication for demo environments
- **demo-prereqs-mongodb** - MongoDB database for demo environments

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
5. More configuration information can be found [here](https://docs.telicent.io/core/getting-started/installation/helm/)

For more detailed information about each component, please consult the individual chart documentation.

## Chart Development

### Conventional Commits

Release Please is used to automatically generate release PRs for Charts as changes are made to Charts.  This detects
eligible changes based upon conventional commit messages, therefore any changes you make to Charts **MUST** use
conventional commit messages in order for a release PR to be generated e.g.

- `chore(chart): Upgrade version to X.Y.Z`
- `fix(chart): Fix missing configuration`
- `feat(chart): Add new storage layer`

### New Producer Chart

First Create a new blank producer from the template:

```bash
helm create -p .dev/starter-charts/producer <producer-name> 
```

Modify the SOURCE_TOPIC, TARGET_TOPIC, image name, along with any other changes this particular producer requires.

## License

Copyright &copy; 2025 Telicent Limited
