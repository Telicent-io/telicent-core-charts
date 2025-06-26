# Smart Cache Search Helm Chart

This Helm chart deploys the Smart Cache Search application. Below is a list of all configurable values in the `values.yaml` file.

## Values

| Key                                   | Type     | Default Value                                           | Description                                                                 |
|---------------------------------------|----------|-------------------------------------------------------|-----------------------------------------------------------------------------|
| `global.jwksUrl`                      | string   | `"https://your.auth.host.here/realms/core/protocol/openid-connect/certs"` | URL for JWKS certificates.                                                 |
| `api.annotations`                     | object   | `{}`                                                   | Additional annotations for the Search API pod.                             |
| `api.replicas`                        | integer  | `1`                                                   | Number of replicas for the Search API.                                     |
| `api.resources`                       | object   | `{}`                                                   | Resource requests and limits for the Search API pod.                       |
| `api.revisionHistoryLimit`            | integer  | `3`                                                   | Number of old ReplicaSets to retain for the Search API.                    |
| `api.image.imagePullSecrets`          | array    | `[]`                                                   | List of secrets to use for pulling the Search API image.                   |
| `api.image.pullPolicy`                | string   | `"IfNotPresent"`                                       | Image pull policy for the Search API.                                      |
| `api.image.repository`                | string   | `"098669589541.dkr.ecr.eu-west-2.amazonaws.com/search-api-server"` | Docker repository for the Search API image.                                |
| `api.image.tag`                       | string   | `""`                                                   | Image tag for the Search API.                                              |
| `api.containerSecurityContext.allowPrivilegeEscalation` | boolean | `false`                                               | Prevent privilege escalation for the Search API container.                 |
| `api.containerSecurityContext.capabilities.drop` | array | `["ALL"]`                                             | Capabilities to drop for the Search API container.                         |
| `api.containerSecurityContext.runAsGroup` | integer | `185`                                                 | Group ID for the Search API container.                                     |
| `api.containerSecurityContext.runAsNonRoot` | boolean | `true`                                                | Ensure the Search API container runs as a non-root user.                   |
| `api.containerSecurityContext.runAsUser` | integer | `185`                                                 | User ID for the Search API container.                                      |
| `api.containerSecurityContext.seccompProfile.type` | string | `"RuntimeDefault"`                                    | Seccomp profile type for the Search API container.                         |
| `api.podSecurityContext.fsGroup`      | integer  | `185`                                                 | Filesystem group ID for the Search API pod.                                |
| `api.podSecurityContext.runAsGroup`   | integer  | `185`                                                 | Group ID for the Search API pod.                                           |
| `api.podSecurityContext.runAsNonRoot` | boolean  | `true`                                                | Ensure the Search API pod runs as a non-root user.                         |
| `api.podSecurityContext.runAsUser`    | integer  | `185`                                                 | User ID for the Search API pod.                                            |
| `api.podSecurityContext.seccompProfile.type` | string | `"RuntimeDefault"`                                    | Seccomp profile type for the Search API pod.                               |
| `api.metrics.service.port`            | integer  | `9464`                                                | Port for the Prometheus service for the Search API.                        |
| `api.extraEnvs`                       | array    | `[]`                                                   | Additional environment variables for the Search API pod.                   |
| `api.configuration.attributeHierarchyUrl` | string | `"http://access-api.tc-system.svc.cluster.local:8080/hierarchies/lookup/{name}"` | URL for the attribute hierarchy endpoint.                                  |
| `api.configuration.elasticHost`       | string   | `"https://your.opensearch.host.here:443"`             | Host for the OpenSearch instance.                                          |
| `api.configuration.elasticIndexNames` | string   | `"search,doc-content"`                                | Names of the indices in OpenSearch.                                        |
| `api.configuration.elasticPort`       | string   | `"443"`                                               | Port for the OpenSearch instance.                                          |
| `api.configuration.elasticClusterPort` | string  | `"9200"`                                              | Port for the OpenSearch cluster.                                           |
| `api.configuration.searchFieldOptions` | string  | `"primaryName^2,*"`                                   | Field options for search, with optional weights.                           |
| `api.configuration.javaOptions`       | string   | `"-XX:MaxRAMPercentage=70.0"`                        | JVM options for the Search API application.                                |
| `api.configuration.opensearchCompatibility` | string | `"true"`                                              | Indicates if the application is compatible with OpenSearch.                |
| `api.configuration.otelMetricsExporter` | string | `"prometheus"`                                        | OpenTelemetry metrics exporter. Options: `prometheus`, `otlp`, `none`.     |
| `api.configuration.otelTracesExporter` | string  | `"none"`                                              | OpenTelemetry traces exporter. Options: `otlp`, `none`.                    |
| `api.configuration.userAttributesUrl` | string   | `"http://access-api.tc-system.svc.cluster.local:8080/users/lookup/{user}"` | URL for the user attributes endpoint.                                      |
| `api.service.port`                    | integer  | `8181`                                                | Port the Search API service will listen on.                                |
| `api.service.type`                    | string   | `"ClusterIP"`                                         | Type of service for the Search API.                                        |
| `api.elasticSecrets.elasticPassword`  | string   | `""`                                                  | Password for the OpenSearch user.                                          |
| `api.elasticSecrets.elasticUser`      | string   | `""`                                                  | Username for the OpenSearch user.                                          |
| `api.elasticSecrets.truststorePass`   | string   | `""`                                                  | Password for the truststore.                                               |
| `projector.annotations`               | object   | `{}`                                                   | Additional annotations for the projector pod.                              |
| `projector.replicas`                  | integer  | `1`                                                   | Number of replicas for the projector.                                      |
| `projector.resources`                 | object   | `{}`                                                   | Resource requests and limits for the projector pod.                        |
| `projector.revisionHistoryLimit`      | integer  | `3`                                                   | Number of old ReplicaSets to retain for the projector.                     |
| `projector.image.imagePullSecrets`    | array    | `[]`                                                   | List of secrets to use for pulling the projector image.                    |
| `projector.image.pullPolicy`          | string   | `"IfNotPresent"`                                       | Image pull policy for the projector.                                       |
| `projector.image.repository`          | string   | `"098669589541.dkr.ecr.eu-west-2.amazonaws.com/smart-cache-elastic-index"` | Docker repository for the projector image.                                 |
| `projector.image.tag`                 | string   | `""`                                                   | Image tag for the projector.                                               |
| `projector.containerSecurityContext.allowPrivilegeEscalation` | boolean | `false`                                               | Prevent privilege escalation for the projector container.                  |
| `projector.containerSecurityContext.capabilities.drop` | array | `["ALL"]`                                             | Capabilities to drop for the projector container.                          |
| `projector.containerSecurityContext.runAsGroup` | integer | `185`                                                 | Group ID for the projector container.                                      |
| `projector.containerSecurityContext.runAsNonRoot` | boolean | `true`                                                | Ensure the projector container runs as a non-root user.                    |
| `projector.containerSecurityContext.runAsUser` | integer | `185`                                                 | User ID for the projector container.                                       |
| `projector.containerSecurityContext.seccompProfile.type` | string | `"RuntimeDefault"`                                    | Seccomp profile type for the projector container.                          |
| `projector.podSecurityContext.fsGroup` | integer | `185`                                                 | Filesystem group ID for the projector pod.                                 |
| `projector.podSecurityContext.runAsGroup` | integer | `185`                                                 | Group ID for the projector pod.                                            |
| `projector.podSecurityContext.runAsNonRoot` | boolean | `true`                                                | Ensure the projector pod runs as a non-root user.                          |
| `projector.podSecurityContext.runAsUser` | integer | `185`                                                 | User ID for the projector pod.                                             |
| `projector.podSecurityContext.seccompProfile.type` | string | `"RuntimeDefault"`                                    | Seccomp profile type for the projector pod.                                |
| `projector.metrics.service.port`      | integer  | `9464`                                                | Port for the Prometheus service for the projector.                         |
| `projector.extraEnvs`                 | array    | `[]`                                                   | Additional environment variables for the projector pod.                    |
| `projector.elasticSecrets.elasticPassword` | string | `""`                                                  | Password for the OpenSearch user for the projector.                        |
| `projector.elasticSecrets.elasticUser` | string  | `""`                                                  | Username for the OpenSearch user for the projector.                        |
| `projector.elasticSecrets.truststorePass` | string | `""`                                                  | Password for the truststore for the projector.                             |
| `projector.configuration.topic`       | string   | `"knowledge"`                                         | Topic to consume from the message broker.                                  |
| `projector.configuration.dlqTopic`    | string   | `"knowledge.dlq"`                                     | Dead-letter queue topic for failed messages.                               |
| `projector.configuration.elasticHost` | string   | `"https://your.opensearch.host.here:443"`             | Host for the OpenSearch instance for the projector.                        |
| `projector.configuration.elasticIndex` | string  | `"search"`                                            | Name of the index in OpenSearch for the projector.                         |
| `projector.configuration.elasticPort` | string   | `"443"`                                               | Port for the OpenSearch instance for the projector.                        |
| `projector.configuration.javaOptions` | string   | `"-XX:MaxRAMPercentage=70.0"`                        | JVM options for the projector application.                                 |
| `projector.configuration.indexBatchSize` | string | `"500"`                                               | Batch size for indexing documents.                                         |
| `projector.configuration.opensearchCompatibility` | string | `"true"`                                              | Indicates if the projector is compatible with OpenSearch.                  |
| `projector.configuration.otelMetricsExporter` | string | `"prometheus"`                                        | OpenTelemetry metrics exporter for the projector. Options: `prometheus`, `otlp`, `none`. |
| `projector.configuration.otelTracesExporter` | string  | `"none"`                                              | OpenTelemetry traces exporter for the projector. Options: `otlp`, `none`.  |
| `map.searchUiMaptilerToken`           | string   | `"your.maptiler.token.here"`                           | Token for MapTiler integration.                                            |
| `map.searchUiMapboxStyleSpecUrl`      | string   | `""`                                                   | URL for Mapbox style specification.                                        |
| `map.searchUiArcgisToken`             | string   | `""`                                                   | Token for ArcGIS integration.                                              |
| `map.existingMapConfigSecretName`     | string   | `""`                                                   | Name of the existing secret for map configuration.                         |
| `fullnameOverride`                    | string   | `""`                                                   | Override the full name of the chart.                                       |
| `nameOverride`                        | string   | `""`                                                   | Custom name for the chart, not fully qualified.                            |

## Usage

To customize the values, create a `values.yaml` file and override the default values as needed.

```bash
helm install my-release ./smart-cache-search -f [values.yaml](http://_vscodecontentref_/1)