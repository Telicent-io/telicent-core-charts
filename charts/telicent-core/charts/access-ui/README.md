# Access UI Helm Chart

This Helm chart deploys the Access UI application. Below is a list of all configurable values in the `values.yaml` file.

## Values

| Key                          | Type     | Default Value                          | Description                                                                 |
|------------------------------|----------|----------------------------------------|-----------------------------------------------------------------------------|
| `configuration.accessUiApiUrl` | string | `"https://your.host.here/api/access"`  | The URL for the Access API.                                                |
| `configuration.signOutUrl`   | string   | `"https://your.host.here/logout"`      | The URL for signing out.                                                   |
| `containerSecurityContext.allowPrivilegeEscalation` | boolean | `false` | Prevent privilege escalation.                                              |
| `containerSecurityContext.capabilities.drop` | array | `["ALL"]` | Capabilities to drop.                                                      |
| `containerSecurityContext.runAsGroup` | integer | `185`                                | Group ID for the container.                                                |
| `containerSecurityContext.runAsNonRoot` | boolean | `true`                               | Ensure the container runs as a non-root user.                              |
| `containerSecurityContext.runAsUser` | integer | `185`                                 | User ID for the container.                                                 |
| `containerSecurityContext.seccompProfile.type` | string | `"RuntimeDefault"`                   | Seccomp profile type.                                                      |
| `fullnameOverride`           | string   | `""`                                  | Override the full name of the chart.                                       |
| `image.imagePullSecrets`     | array    | `[]`                                  | List of secrets to use for pulling the image.                              |
| `image.pullPolicy`           | string   | `"Always"`                             | Image pull policy.                                                         |
| `image.repository`           | string   | `"telicent/telicent-access"`           | Docker repository for the image.                                           |
| `image.tag`                  | string   | `""`                                  | Image tag to use.                                                          |
| `nameOverride`               | string   | `""`                                  | Custom name for the chart, not fully qualified.                            |
| `podSecurityContext.fsGroup` | integer  | `185`                                  | Filesystem group ID for the pod.                                           |
| `podSecurityContext.runAsGroup` | integer | `185`                                | Group ID for the pod.                                                      |
| `podSecurityContext.runAsNonRoot` | boolean | `true`                              | Ensure the pod runs as a non-root user.                                    |
| `podSecurityContext.runAsUser` | integer | `185`                                 | User ID for the pod.                                                       |
| `podSecurityContext.seccompProfile.type` | string | `"RuntimeDefault"`                  | Seccomp profile type.                                                      |
| `replicas`                   | integer  | `1`                                   | Number of replicas.                                                        |
| `resources.requests`         | object   | `{}`                                  | Resource requests for the pod.                                             |
| `resources.limits`           | object   | `{}`                                  | Resource limits for the pod.                                               |
| `revisionHistoryLimit`       | integer  | `3`                                   | Number of old ReplicaSets to retain.                                       |
| `service.port`               | integer  | `8080`                                | Port the service will listen on.                                           |
| `service.type`               | string   | `"ClusterIP"`                         | Service type.                                                              |
| `serviceAccount.annotations` | object   | `{}`                                  | Additional annotations for the service account.                            |
| `serviceAccount.name`        | string   | `""`                                  | Name of the service account.                                               |

## Usage

To customize the values, create a `values.yaml` file and override the default values as needed.

```bash
helm install my-release ./access-ui -f [values.yaml](http://_vscodecontentref_/1)