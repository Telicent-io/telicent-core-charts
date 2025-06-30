# Smart Cache Graph Helm Chart

This Helm chart deploys the Smart Cache Graph application. Below is a list of all configurable values in the `values.yaml` file.

## Values

| Key                                   | Type     | Default Value                                           | Description                                                                 |
|---------------------------------------|----------|-------------------------------------------------------|-----------------------------------------------------------------------------|
| `global.jwksUrl`                      | string   | `"https://AUTH_DOMAIN/realms/core/protocol/openid-connect/certs"` | URL for JWKS certificates.                                                 |
| `configuration.attributeHierarchyUrl` | string   | `""`                                                   | URL for the attribute hierarchy endpoint.                                   |
| `configuration.javaOptions`           | string   | `"-Xmx5120m -Xms2048m -Djavax.net.ssl.trustStore=/app/config/truststore/truststore.jks"` | JVM options for the application.                                           |
| `configuration.otelMetricsExporter`   | string   | `"prometheus"`                                         | OpenTelemetry metrics exporter. Options: `prometheus`, `otlp`, `none`.     |
| `configuration.otelTracesExporter`    | string   | `"none"`                                               | OpenTelemetry traces exporter. Options: `otlp`, `none`.                    |
| `configuration.userAttributesUrl`     | string   | `""`                                                   | URL for the user attributes endpoint.                                       |
| `fullnameOverride`                    | string   | `""`                                                   | Override the full name of the chart.                                       |
| `image.imagePullSecrets`              | array    | `[]`                                                   | List of secrets to use for pulling the image.                              |
| `image.pullPolicy`                    | string   | `"IfNotPresent"`                                       | Image pull policy.                                                         |
| `image.repository`                    | string   | `"telicent/smart-cache-graph"`                        | Docker repository for the image.                                           |
| `image.tag`                           | string   | `""`                                                   | Image tag to use.                                                          |
| `metrics.service.port`                | integer  | `9464`                                                 | Port for the Prometheus service.                                           |
| `nameOverride`                        | string   | `""`                                                   | Custom name for the chart, not fully qualified.                            |
| `persistentVolumeClaims.backupsVolume.size` | string | `"100Gi"`                                             | Size of the backups volume.                                                |
| `persistentVolumeClaims.backupsVolume.storageClass` | string | `"gp3-enc"`                                           | Storage class for the backups volume.                                      |
| `persistentVolumeClaims.datasetsVolume.size` | string | `"25Gi"`                                              | Size of the datasets volume.                                               |
| `persistentVolumeClaims.datasetsVolume.storageClass` | string | `"gp3-enc"`                                           | Storage class for the datasets volume.                                     |
| `annotations`                         | object   | `{}`                                                   | Additional annotations for resources.                                      |
| `replicas`                            | integer  | `1`                                                   | Number of replicas.                                                        |
| `resources.requests`                  | object   | `{}`                                                   | Resource requests for the pod.                                             |
| `resources.limits`                    | object   | `{}`                                                   | Resource limits for the pod.                                               |
| `revisionHistoryLimit`                | integer  | `3`                                                   | Number of old ReplicaSets to retain.                                       |
| `service.port`                        | integer  | `8080`                                                | Port the service will listen on.                                           |
| `service.type`                        | string   | `"ClusterIP"`                                         | Service type.                                                              |
| `serviceAccount.annotations`          | object   | `{}`                                                   | Additional annotations for the service account.                            |
| `serviceAccount.name`                 | string   | `""`                                                   | Name of the service account.                                               |

## Usage

To customize the values, create a `values.yaml` file and override the default values as needed.

```bash
helm install my-release ./smart-cache-graph -f [values.yaml](http://_vscodecontentref_/1)
