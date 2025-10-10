# Helm Chart for Telicent Data Pipeline

Telicent Data is a Kubernetes-native data ingestion pipeline that feeds data into the Telicent Core platform. This chart manages multiple data producers as Kubernetes Jobs, enabling flexible and scalable data processing workflows.

## Introduction

This chart bootstraps a data ingestion pipeline on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager. It creates and manages data producer jobs that process and ingest various types of data (ontologies, regions, entities) into Kafka topics for consumption by Telicent Core applications.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+
- Access to a Kafka cluster (configured via global parameters)
- Telicent Core platform (target for the ingested data)

## Architecture

The telicent-data chart implements a job-based data pipeline architecture:

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Data Sources  │───▶│  Producer Jobs   │───▶│  Kafka Topics   │
│                 │    │                  │    │                 │
│ • Ontologies    │    │ • IES Ontology   │    │ • knowledge     │
│ • Region Data   │    │ • Regions        │    │ • regions       │
│ • RDF/OWL       │    │ • Adapters       │    │ • entities      │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                │
                                ▼
                       ┌─────────────────┐
                       │ Telicent Core   │
                       │ Applications    │
                       └─────────────────┘
```

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

Global configuration parameters shared across Telicent components. These configure the target environment and infrastructure.

| Name | Description | Value |
|------|-------------|-------|
| `global.imageRegistry` | Global image registry | `""` |
| `global.imagePullSecrets` | Global registry secret names as an array | `[]` |
| `global.appHostDomain` | Domain of the target Telicent Core application | `apps.telicent.io` |
| `global.kafka.bootstrapServers` | Kafka cluster endpoint for data ingestion | `kafka-bootstrap.kafka.svc.cluster.local:9092` |
| `global.kafka.username` | Username for Kafka authentication | `your.kafka.username.here` |
| `global.kafka.password` | Password for Kafka authentication | `your.kafka.password.here` |

### Producer Configuration

Each producer can be configured independently with its own image, resources, and job parameters.

#### Common Producer Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `producers.<name>.enabled` | Enable/disable the producer | `true` |
| `producers.<name>.image.repository` | Container image repository | varies by producer |
| `producers.<name>.image.tag` | Container image tag | `""` (uses Chart.AppVersion) |
| `producers.<name>.image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `producers.<name>.resources` | Resource requests and limits | `{}` |
| `producers.<name>.env` | Environment variables | `{}` |
| `producers.<name>.job.backoffLimit` | Number of retries for failed jobs | `3` |
| `producers.<name>.job.completions` | Number of successful completions required | `1` |
| `producers.<name>.job.parallelism` | Number of parallel executions | `1` |
| `producers.<name>.job.ttlSecondsAfterFinished` | TTL for completed jobs | `null` |

#### Available Producers

| Producer | Image | Purpose |
|----------|-------|---------|
| `ies-ontology-producer` | `telicent/tc-ies-ontology-producer` | Core IES ontology ingestion |
| `ies-regions-producer` | `telicent/tc-ies-regions-producer` | Geographical region data processing |
| `ies-regions-ontology-adapter` | `telicent/tc-ies-regions-ontology-adapter` | Region data format adaptation |
| `ontologies-rdf-rdfs-owl-producer` | `telicent/tc-ontologies-rdf-rdfs-owl-producer` | RDF/RDFS/OWL ontology ingestion |

### Example Configuration

```yaml
global:
  appHostDomain: "my-telicent.example.com"
  kafka:
    bootstrapServers: "my-kafka-cluster:9092"
    username: "data-pipeline-user"
    password: "secure-password"

producers:
  ies-regions-producer:
    enabled: true
    resources:
      requests:
        memory: "512Mi"
        cpu: "200m"
      limits:
        memory: "1Gi"
        cpu: "500m"
    env:
      BATCH_SIZE: "1000"
      LOG_LEVEL: "INFO"
    job:
      backoffLimit: 5
      ttlSecondsAfterFinished: 3600

  ies-ontology-producer:
    enabled: false  # Disable this producer
```

## Troubleshooting

### Common Issues

#### Jobs Stuck in Pending State
```console
# Check node resources
kubectl describe nodes

# Check image pull issues
kubectl describe job <job-name>
```

#### Jobs Failing Repeatedly
```console
# Check job logs
kubectl logs -l app.kubernetes.io/producer=<producer-name>

# Check Kafka connectivity
kubectl exec -it <pod-name> -- curl -v kafka-bootstrap.kafka.svc.cluster.local:9092
```

#### Data Not Appearing in Core
1. Verify Kafka topics exist and contain data
2. Check Telicent Core application logs
3. Validate data format and schema compatibility

### Useful Commands

```console
# View all producer jobs
kubectl get jobs -l app.kubernetes.io/name=telicent-data

# Check job completion status
kubectl get jobs -l app.kubernetes.io/name=telicent-data -o wide

# Delete failed jobs for retry
kubectl delete jobs -l app.kubernetes.io/name=telicent-data --field-selector status.failed=1

# Scale job parallelism
helm upgrade telicent-data ./charts/telicent-data --set producers.ies-regions-producer.job.parallelism=3
```

## Integration with Telicent Core

This chart is designed to work with the broader Telicent ecosystem:

- **Telicent Core**: The target platform that consumes the ingested data
- **Kafka**: Message broker for reliable data streaming
- **Istio** (optional): Service mesh for secure communication
- **Monitoring**: Prometheus/Grafana integration for job monitoring

## Development

### Adding New Producers

1. Add producer configuration to `values.yaml`
2. Ensure the producer image follows Telicent data pipeline conventions
3. Configure appropriate Kafka topics and data formats
4. Test with both enabled and disabled states

### Custom Data Sources

To add custom data sources:

1. Create a new producer entry in `values.yaml`
2. Configure the container image and environment variables
3. Set appropriate resource limits based on data volume
4. Configure job retry and cleanup policies

## Configuration and installation details

## Parameters


## License

Copyright &copy; 2025 Telicent Limited

## Support

- **Issues**: [GitHub Issues](https://github.com/Telicent-IO/telicent-core-charts/issues)
- **Chart Repository**: [Telicent Core Charts](https://github.com/Telicent-IO/telicent-core-charts)
