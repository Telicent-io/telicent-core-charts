# Access API Helm Chart

This Helm chart deploys the Access API application. Below is a list of all configurable values in the `values.yaml` file.

## Values

| Key                          | Type     | Default Value                          | Description                                                                 |
|------------------------------|----------|----------------------------------------|-----------------------------------------------------------------------------|
| `mongo.url`                  | string   | `"mongodb://example.mongodb.net"`      | MongoDB connection URL.                                                    |
| `mongo.username`             | string   | `"root"`                               | MongoDB username.                                                          |
| `mongo.password`             | string   | `"your.mongo.password.here"`           | MongoDB password.                                                          |
| `mongo.database`             | string   | `"access"`                             | MongoDB database name.                                                     |
| `mongo.connectionStringOptions` | string | `"authMechanism=SCRAM-SHA-1&retryWrites=false"` | Additional connection string options for MongoDB.                          |
| `mongo.retryRewrites`        | string   | `"false"`                              | Retry rewrites option for MongoDB.                                         |
| `mongo.existingMongoPasswordSecret`             | string   | `""`               | Name of the existing secret for configuration.                             |
| `config.debug`               | boolean  | `true`                                 | Enable debug logging.                                                      |
| `config.openidProviderUrl`   | string   | `"https://oidc.example.com"`           | The URL of the OIDC provider.                                              |
| `config.scimEnabled`         | boolean  | `true`                                 | Enable SCIM user management.                                               |
| `containerSecurityContext.allowPrivilegeEscalation` | boolean | `false` | Allow privilege escalation.                                                |
| `containerSecurityContext.capabilities.drop` | array | `["ALL"]` | Capabilities to drop.                                                      |
| `containerSecurityContext.runAsGroup` | integer | `185` | Group ID to run as.                                                        |
| `containerSecurityContext.runAsNonRoot` | boolean | `true` | Run as non-root user.                                                      |
| `containerSecurityContext.runAsUser` | integer | `185` | User ID to run as.                                                         |
| `containerSecurityContext.seccompProfile.type` | string | `"RuntimeDefault"` | Seccomp profile type.                                                      |
| `existingConfigmap`          | string   | `"existing-configmap-name"`            | Name of the existing configmap for configuration.                          |
| `existingCacertConfigmap`    | string   | `"existing-cacert-configmap-name"`     | Name of the existing configmap for extra certificates.                     |
| `fullnameOverride`           | string   | `"custom-fullname"`                    | Override the full name of the chart.                                       |
| `cacert`                     | string   | `"path/to/cacert.pem"`                 | Path to the extra certificates to be trusted.                              |
| `image.imagePullSecrets`     | array    | `[]`                                  | List of secrets to use for pulling the image.                              |
| `image.pullPolicy`           | string   | `"Always"`                             | Image pull policy.                                                         |
| `image.repository`           | string   | `"telicent/telicent-access-api"`       | Image repository.                                                          |
| `image.tag`                  | string   | `"latest"`                             | Image tag.                                                                 |
| `podSecurityContext.fsGroup` | integer  | `185`                                  | Filesystem group ID.                                                       |
| `podSecurityContext.runAsGroup` | integer | `185`                                | Group ID to run as.                                                        |
| `podSecurityContext.runAsNonRoot` | boolean | `true`                              | Run as non-root user.                                                      |
| `podSecurityContext.runAsUser` | integer | `185`                                 | User ID to run as.                                                         |
| `podSecurityContext.seccompProfile.type` | string | `"RuntimeDefault"`                  | Seccomp profile type.                                                      |
| `replicas`                   | integer  | `3`                                   | Number of replicas.                                                        |
| `resources.requests.cpu`     | string   | `"500m"`                              | CPU request.                                                               |
| `resources.requests.memory`  | string   | `"512Mi"`                             | Memory request.                                                            |
| `resources.limits.cpu`       | string   | `"1"`                                 | CPU limit.                                                                 |
| `resources.limits.memory`    | string   | `"1Gi"`                               | Memory limit.                                                              |
| `revisionHistoryLimit`       | integer  | `5`                                   | Revision history limit.                                                    |
| `service.port`               | integer  | `8080`                                | Service port.                                                              |
| `service.type`               | string   | `"ClusterIP"`                         | Service type.                                                              |
| `serviceAccount.annotations` | object   | `{}`                                  | Annotations for the service account.                                       |
| `serviceAccount.name`        | string   | `""`                                  | Name of the service account.                                               |

## Usage

To customize the values, create a `values.yaml` file and override the default values as needed.
```bash
helm install my-release ./access-api -f [values.yaml](http://_vscodecontentref_/1)