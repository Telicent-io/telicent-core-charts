# Helm Chart for Telicent Data Pipeline

Telicent Data is a Kubernetes-native data ingestion pipeline that feeds data into the Telicent Core platform. This chart manages multiple data producers as Kubernetes Jobs, enabling flexible and scalable data processing workflows.

## Introduction

This chart bootstraps a data ingestion pipeline on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager. It creates and manages data producer jobs that process and ingest various types of data (ontologies, regions, entities) into Kafka topics for consumption by Telicent Core applications.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+
- Access to a Kafka cluster (configured via global parameters)
- Telicent Core platform (target for the ingested data)

## Installing the Chart

To install the chart with the release name `telicent-data`:

```console
helm install telicent-data ./charts/telicent-data
```

To install with custom configuration:

```console
helm install telicent-data ./charts/telicent-data -f custom-values.yaml
```

## Uninstalling the Chart

To uninstall/delete the `telicent-data` deployment:

```console
helm delete telicent-data
```

The command removes all Kubernetes Jobs, Secrets, and ServiceAccounts associated with the chart.

## Data Producers

The chart includes several pre-configured data producers that can be enabled/disabled individually:

### Available Producers

| Producer | Description | Default Status |
|----------|-------------|----------------|
| `ies-ontology-producer` | Ingests core IES ontology definitions | Enabled |
| `ies-regions-producer` | Processes geographical region data | Enabled |
| `ies-regions-ontology-adapter` | Adapts region data to IES format | Enabled |
| `ontologies-rdf-rdfs-owl-producer` | Ingests RDF/RDFS/OWL ontologies | Enabled |

### Managing Producers

Enable a specific producer:
```console
helm upgrade telicent-data ./charts/telicent-data --set producers.ies-regions-producer.enabled=true
```

Disable a producer:
```console
helm upgrade telicent-data ./charts/telicent-data --set producers.ies-ontology-producer.enabled=false
```

Configure producer resources:
```console
helm upgrade telicent-data ./charts/telicent-data --set producers.ies-regions-producer.resources.requests.memory=512Mi
```

## Monitoring and Operations

### Job Status

Check the status of all data ingestion jobs:
```console
kubectl get jobs -l app.kubernetes.io/name=telicent-data
```

View logs for a specific producer:
```console
kubectl logs -l app.kubernetes.io/producer=ies-regions-producer
```

### Job Management

Re-run a failed job:
```console
kubectl delete job telicent-data-ies-regions-producer
helm upgrade telicent-data ./charts/telicent-data
```

Clean up completed jobs:
```console
kubectl delete jobs -l app.kubernetes.io/name=telicent-data --field-selector status.successful=1
```

## Configuration and Installation Details

## Parameters

### Global Parameters

Contains global parameters. Not explicitly used in this chart, added to maintain consistency across Telicent charts.
These parameters can be referenced in sub-charts as `.Values.global.<parameter-name>`.

| Name                             | Description                                                                                                                     | Value                                            |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| `global.imageRegistry`           | Global image registry                                                                                                           | `""`                                             |
| `global.imagePullSecrets`        | Global registry secret names as an array                                                                                        | `[]`                                             |
| `global.enterprise`              | Enable enterprise mode, adding additional features and configurations                                                           | `false`                                          |
| `global.appHostDomain`           | Domain associated with Telicent application services. This value cannot be changed after it is set                              | `""`                                             |
| `global.authHostDomain`          | Domain associated with Telicent authentication services, including OIDC providers. This value cannot be changed after it is set | `""`                                             |
| `global.groupsClaim`             | Key used to retrieve groups from the OIDC provider                                                                              | `groups`                                         |
| `global.jwksUrl`                 | Endpoint exposing multiple public keys represented as JWKs (JSON Web Key Set)                                                   | `https://{yourAuthdomain}/.well-known/jwks.json` |
| `global.istioNamespace`          | Namespace in which Istio is deployed                                                                                            | `istio-system`                                   |
| `global.istioServiceAccountName` | Name of the Istio service account                                                                                               | `istio-ingress`                                  |
| `global.istioGatewayName`        | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)                                                       | `ingress-gateway`                                |

### Kafka Parameters

| Name                                    | Description                                                                                                       | Value                                          |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers                                                           | `kafka-bootstrap.kafka.svc.cluster.local:9092` |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration (preferred over individual settings below for security) | `""`                                           |
| `global.kafka.username`                 | Username for Kafka authentication                                                                                 | `your.kafka.username.here`                     |
| `global.kafka.password`                 | Password for Kafka authentication                                                                                 | `your.kafka.password.here`                     |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                                                                             | `SASL_SSL`                                     |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication                                                                      | `SCRAM-SHA-512`                                |
| `global.truststore.existingSecret`      | Name of an existing secret containing the truststore                                                              | `""`                                           |
| `global.truststore.mountPath`           | The mount path for the truststore in the container                                                                | `/app/config/truststore`                       |

### Kafka Topics Parameters

| Name                  | Description                                                        | Value   |
| --------------------- | ------------------------------------------------------------------ | ------- |
| `kafkaTopics.enabled` | Enable or disable the creation of Kafka topics during installation | `false` |
| `kafkaTopics.topics`  | List of Kafka topics to be created                                 | `[]`    |


## License

Copyright &copy; 2025 Telicent Limited

## Support

- **Issues**: [GitHub Issues](https://github.com/Telicent-IO/telicent-core-charts/issues)
- **Chart Repository**: [Telicent Core Charts](https://github.com/Telicent-IO/telicent-core-charts)
