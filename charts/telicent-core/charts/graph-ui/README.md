# Graph UI Helm Chart

This Helm chart deploys the Graph UI application. Below is a list of all configurable values in the `values.yaml` file.

## Values

| Key                                   | Type     | Default Value                                           | Description                                                                 |
|---------------------------------------|----------|-------------------------------------------------------|-----------------------------------------------------------------------------|
| `global.appHostDomain`                | string   | `"apps.telicent.io"`                                   | Domain for the Telicent applications.                                      |
| `global.authHostDomain`               | string   | `"auth.telicent.io"`                                   | Domain for the Telicent authentication service.                            |
| `configuration.accessApiEndpoint`     | string   | `"https://access-api.telicent.io"`                     | Endpoint for the Access API.                                               |
| `configuration.userPortalUiDeployed`  | boolean  | `true`                                                 | Indicates if the User Portal UI is deployed.                               |
| `configuration.graphUiDeployed`       | boolean  | `true`                                                 | Indicates if the Graph UI is deployed.                                     |
| `configuration.dataCatalogUiDeployed` | boolean  | `true`                                                 | Indicates if the Data Catalog UI is deployed.                              |
| `map.searchUiMaptilerToken`           | string   | `"your.maptiler.token.here"`                           | Token for MapTiler integration.                                            |
| `map.searchUiMapboxStyleSpecUrl`      | string   | `""`                                                   | URL for Mapbox style specification.                                        |
| `map.searchUiArcgisToken`             | string   | `""`                                                   | Token for ArcGIS integration.                                              |
| `map.existingMapConfigSecretName`     | string   | `""`                                                   | Name of the existing secret for map configuration.                         |
| `affinity`                            | object   | `{}`                                                   | Affinity rules for pod scheduling.                                         |
| `annotations`                         | object   | `{}`                                                   | Additional annotations for resources.                                      |
| `containerSecurityContext.allowPrivilegeEscalation` | boolean | `false`                                               | Prevent privilege escalation.                                              |
| `containerSecurityContext.capabilities.drop` | array | `["ALL"]`                                             | Capabilities to drop.                                                      |
| `containerSecurityContext.runAsGroup` | integer  | `185`                                                 | Group ID for the container.                                                |
| `containerSecurityContext.runAsNonRoot` | boolean | `true`                                                | Ensure the container runs as a non-root user.                              |
| `containerSecurityContext.runAsUser`  | integer  | `185`                                                 | User ID for the container.                                                 |
| `containerSecurityContext.seccompProfile.type` | string | `"RuntimeDefault"`                                    | Seccomp profile type.                                                      |
| `fullnameOverride`                    | string   | `""`                                                   | Override the full name of the chart.                                       |
| `image.pullPolicy`                    | string   | `"IfNotPresent"`                                       | Image pull policy.                                                         |
| `image.repository`                    | string   | `"098669589541.dkr.ecr.eu-west-2.amazonaws.com/telicent-graph"` | Docker repository for the image.                                           |
| `image.tag`                           | string   | `""`                                                   | Image tag to use.                                                          |
| `nameOverride`                        | string   | `""`                                                   | Custom name for the chart, not fully qualified.                            |
| `nodeSelector`                        | object   | `{}`                                                   | Node selector rules for pod scheduling.                                    |
| `podSecurityContext.fsGroup`          | integer  | `185`                                                 | Filesystem group ID for the pod.                                           |
| `podSecurityContext.runAsGroup`       | integer  | `185`                                                 | Group ID for the pod.                                                      |
| `podSecurityContext.runAsNonRoot`     | boolean  | `true`                                                | Ensure the pod runs as a non-root user.                                    |
| `podSecurityContext.runAsUser`        | integer  | `185`                                                 | User ID for the pod.                                                       |
| `podSecurityContext.seccompProfile.type` | string | `"RuntimeDefault"`                                    | Seccomp profile type.                                                      |
| `replicas`                            | integer  | `1`                                                   | Number of replicas.                                                        |
| `resources.requests`                  | object   | `{}`                                                   | Resource requests for the pod.                                             |
| `resources.limits`                    | object   | `{}`                                                   | Resource limits for the pod.                                               |
| `revisionHistoryLimit`                | integer  | `3`                                                   | Number of old ReplicaSets to retain.                                       |
| `service.port`                        | integer  | `8080`                                                | Port the service will listen on.                                           |
| `service.type`                        | string   | `"ClusterIP"`                                         | Service type.                                                              |
| `serviceAccount.annotations`          | object   | `{}`                                                   | Additional annotations for the service account.                            |
| `serviceAccount.name`                 | string   | `""`                                                   | Name of the service account.                                               |
| `tolerations`                         | array    | `[]`                                                  | Tolerations for pod scheduling.                                            |

## Usage

To customize the values, create a `values.yaml` file and override the default values as needed.

```bash
helm install my-release ./graph-ui -f [values.yaml](http://_vscodecontentref_/1)