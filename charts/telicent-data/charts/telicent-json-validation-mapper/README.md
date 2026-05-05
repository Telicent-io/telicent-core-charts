# JSON Validation Mapper

A Helm chart for deploying the **JSON Validation Mapper** — a Kafka-to-Kafka message validator that reads raw messages from a source topic, validates them against one or more JSON schemas, and routes them accordingly:

- **Valid messages** are forwarded to the validated target topic
- **Invalid messages** are routed to the Dead Letter Queue (DLQ)

## Overview

The JSON Validation Mapper provides schema-based quality gating for Kafka message pipelines. JSON schemas are mounted into the container and used to validate each incoming message. This ensures only conformant messages propagate downstream.

Key features:

- **Schema-driven validation**: Mount any number of JSON schema files; messages are checked against the appropriate schema
- **DLQ support**: Messages that fail validation are automatically routed to a dead letter queue rather than being dropped silently
- **Kafka Integration**: Configurable source, target, and DLQ topics with full SASL/SSL authentication support
- **Kubernetes Best Practices**: Includes service accounts, security contexts, resource management, and health probes

## How It Works

```
Kafka (raw topic)
      │
      ▼
JSON Validation Mapper
      │
      ├── valid   ──► Kafka (validated topic)
      │
      └── invalid ──► Kafka (DLQ)
```

The mapper reads each message from `configuration.sourceTopic`, validates the message body against the JSON schemas found in `configuration.schemaDir`, and either publishes it to `configuration.targetTopic` on success or routes it to the DLQ on failure.

## Usage

### Installing the Chart

```bash
helm install json-validation-mapper ./charts/json-validation-mapper -n your-namespace
```

### Upgrading

```bash
helm upgrade json-validation-mapper ./charts/json-validation-mapper -n your-namespace
```

### Uninstalling

```bash
helm uninstall json-validation-mapper -n your-namespace
```

## Configuration

### Schema

Exactly one JSON schema file must be provided. There are two ways to supply it:

#### Option 1: Inline (chart creates the ConfigMap)

Provide `schema.name` and `schema.content` in `values.yaml`. The chart creates a ConfigMap and mounts it into `/app/schemas/` automatically. Use a YAML block scalar (`|-`) for the content to keep the JSON readable without escaping.

The filename must end in `.schema.json`.

```yaml
schema:
  name: canonical-event.schema.json
  content: |-
    {
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "Canonical Event",
      "description": "Schema for validating canonical event messages",
      "type": "array",
      "minItems": 1,
      "items": {
        "type": "object",
        "required": ["schema_version", "id", "types"],
        "properties": {
          "schema_version": {
            "type": "string",
            "description": "Schema version, e.g. 0.1.0",
            "pattern": "^[0-9]+\\.[0-9]+\\.[0-9]+.*$"
          },
          "id": {
            "type": "string",
            "description": "Unique event identifier, e.g. EVT-001",
            "pattern": "^[A-Za-z0-9][A-Za-z0-9._-]*$"
          },
          "types": {
            "type": "array",
            "description": "One or more event type URIs",
            "minItems": 1,
            "items": {
              "type": "string"
            }
          },
          "start_datetime": {
            "type": "string",
            "format": "date-time",
            "description": "ISO 8601 start date/time of the event"
          },
          "end_datetime": {
            "type": "string",
            "format": "date-time",
            "description": "ISO 8601 end date/time of the event"
          },
          "location": {
            "type": "object",
            "description": "Geographic location of the event",
            "properties": {
              "lat": { "type": "number" },
              "lon": { "type": "number" }
            }
          }
        }
      }
    }
```

#### Option 2: Existing ConfigMap

If the schema is managed externally (e.g. via Flux or a separate Helm release), reference it by name using `schema.existingConfigMapName`. The chart will mount it directly without creating a new ConfigMap.

```yaml
schema:
  existingConfigMapName: my-schema-configmap
```

The ConfigMap must conform to the following requirements:

- It must contain **exactly one key**
- The key name must end in `.schema.json`
- The value must be a valid JSON schema string

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-schema-configmap
data:
  canonical-event.schema.json: |
    {
      "$schema": "http://json-schema.org/draft-07/schema#",
      "type": "object"
    }
```

> **Note:** `schema.existingConfigMapName` and `schema.name` are mutually exclusive. Setting both will cause the Helm install to fail.

If `schema.name` or `schema.content` is missing when not using an existing ConfigMap, the Helm install will fail with a descriptive error.

### Topics

Configure the source and target topics in `values.yaml`:

```yaml
configuration:
  sourceTopic: raw-lddf-observations       # Topic to consume raw messages from
  targetTopic: canonical.event.validated   # Topic to publish valid messages to
  defaultDataNamespace: http://telicent.io/data#
```

### Kafka Authentication

```yaml
kafka:
  # Option 1: Reference an existing Kubernetes secret (recommended for production)
  existingConfigSecretName: "my-kafka-credentials"

  # Option 2: Provide credentials directly (development only)
  bootstrapServers: "kafka-bootstrap.kafka.svc.cluster.local:9092"
  username: "your.kafka.username.here"
  password: "your.kafka.password.here"
  protocol: "SASL_SSL"
  mechanism: "SCRAM-SHA-512"
```

**Best Practice**: For production deployments, always use `existingConfigSecretName` to reference a pre-created Kubernetes secret containing your Kafka credentials.

## Architecture

The deployment includes:

- **Deployment**: Single replica by default (configurable)
- **ConfigMap**: Stores non-sensitive configuration (topics, schema directory, data namespace)
- **Secret**: Stores Kafka authentication credentials
- **ServiceAccount**: For pod identity and RBAC

## Chart Structure

```
json-validation-mapper/
├── Chart.yaml              # Chart metadata
├── values.yaml             # Default configuration values
├── README.md               # This file
└── templates/
    ├── _helpers.tpl        # Template helpers
    ├── configMap.yaml      # Configuration as environment variables
    ├── deployment.yaml     # Main deployment manifest
    ├── secret.yaml         # Kafka credentials secret
    ├── NOTES.txt           # Post-install notes
    └── serviceaccount.yaml # Service account (if created)
```

## Advanced Configuration

### Resources

```yaml
resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 250m
    memory: 256Mi
```

### Pod Annotations and Labels

```yaml
podAnnotations:
  prometheus.io/scrape: "true"

podLabels:
  team: data-engineering
```

### Node Affinity and Tolerations

```yaml
nodeSelector:
  workload: data-processing

tolerations:
  - key: "workload"
    operator: "Equal"
    value: "data-processing"
    effect: "NoSchedule"
```

## Requirements

- Kubernetes 1.19+
- Helm 3.0+
- Access to a Kafka cluster
- JSON schema files for message validation

## Support

For issues or questions, please contact the Telicent platform team.

## Parameters

### Image Parameters

| Name               | Description                                                  | Value                                     |
| ------------------ | ------------------------------------------------------------ | ----------------------------------------- |
| `image.repository` | Container image repository                                   | `quay.io/telicent/json-validation-mapper` |
| `image.pullPolicy` | Container image pull policy                                  | `IfNotPresent`                            |
| `image.tag`        | Container image tag, overrides the chart appVersion when set | `""`                                      |
| `imagePullSecrets` | Secrets for pulling images from a private registry           | `[]`                                      |
| `nameOverride`     | Override for the chart name                                  | `""`                                      |
| `fullnameOverride` | Full override for the chart name                             | `""`                                      |

### Service Account Parameters

| Name                         | Description                                                                                                        | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------ | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                                              | `true` |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                                             | `true` |
| `serviceAccount.annotations` | Additional annotations for the service account                                                                     | `{}`   |
| `serviceAccount.name`        | Name of the service account to use. If not set and create is true, a name is generated using the fullname template | `""`   |

### Pod Parameters

| Name                 | Description                        | Value |
| -------------------- | ---------------------------------- | ----- |
| `podAnnotations`     | Additional annotations for the Pod | `{}`  |
| `podLabels`          | Additional labels for the Pod      | `{}`  |
| `podSecurityContext` | Security context for the Pod       | `{}`  |
| `securityContext`    | Security context for the container | `{}`  |

### Resource Parameters

| Name             | Description                                      | Value |
| ---------------- | ------------------------------------------------ | ----- |
| `resources`      | Resource requests and limits for the container   | `{}`  |
| `livenessProbe`  | Liveness probe configuration for the container   | `{}`  |
| `readinessProbe` | Readiness probe configuration for the container  | `{}`  |
| `volumes`        | Additional volumes to add to the Deployment      | `[]`  |
| `volumeMounts`   | Additional volume mounts to add to the container | `[]`  |
| `nodeSelector`   | Node selector for pod assignment                 | `{}`  |
| `tolerations`    | Tolerations for pod assignment                   | `[]`  |
| `affinity`       | Affinity rules for pod assignment                | `{}`  |

### Schema Parameters

The JSON schema used to validate incoming Kafka messages. Exactly one schema
file is supported. The file will be mounted at /app/schemas/<schema.name>.
Either provide an existing ConfigMap name via schema.existingConfigMapName,
or provide schema.name and schema.content to have the chart create one.
The ConfigMap must contain exactly one key whose name ends in .schema.json.

| Name                           | Description                                                                                                       | Value |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------------- | ----- |
| `schema.existingConfigMapName` | Name of an existing ConfigMap containing the JSON schema (mutually exclusive with schema.name and schema.content) | `""`  |
| `schema.name`                  | Filename of the JSON schema file (must end in .schema.json, ignored if existingConfigMapName is set)              | `""`  |
| `schema.content`               | Raw content of the JSON schema file (ignored if existingConfigMapName is set)                                     | `{}`  |

### Configuration Parameters

General configuration options for the JSON Validation Mapper.

| Name                                 | Description                                                                                        | Value                      |
| ------------------------------------ | -------------------------------------------------------------------------------------------------- | -------------------------- |
| `configuration.sourceTopic`          | Topic to read raw Kafka messages from                                                              | `""`                       |
| `configuration.targetTopic`          | Topic to write validated Kafka messages to                                                         | `""`                       |
| `configuration.defaultDataNamespace` | Default namespace for data                                                                         | `http://telicent.io/data#` |
| `configuration.componentOf`          | Used to classify what this instance of the validation mapper will be doing (canonical-events etc.) | `""`                       |

### Kafka Parameters

Kafka configuration for connecting the JSON Validation Mapper to a Kafka cluster.

| Name                             | Description                                                                                                       | Value                                          |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers                                                           | `kafka-bootstrap.kafka.svc.cluster.local:9092` |
| `kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration (preferred over individual settings below for security) | `""`                                           |
| `kafka.username`                 | Username for Kafka authentication                                                                                 | `your.kafka.username.here`                     |
| `kafka.password`                 | Password for Kafka authentication                                                                                 | `your.kafka.password.here`                     |
| `kafka.protocol`                 | Protocol used for Kafka communication                                                                             | `SASL_SSL`                                     |
| `kafka.mechanism`                | SASL mechanism used for Kafka authentication                                                                      | `SCRAM-SHA-512`                                |

## License

Copyright © Telicent Ltd

