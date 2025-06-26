# User Preferences API Helm Chart

This Helm chart deploys the User Preferences API application. Below is a list of all configurable values in the `values.yaml` file.

## Values

| Key                                   | Type     | Default Value                                           | Description                                                                 |
|---------------------------------------|----------|-------------------------------------------------------|-----------------------------------------------------------------------------|
| `global.existingTruststoreSecretName` | string   | `""`                                                   | Existing truststore secret name |
| `configuration.javaOptions`           | string   | `"-Xms512m -Xmx512m"`                                  | JVM options for the application.                                           |
| `mongo.url`                           | string   | `"mongodb://mongodb-demo-prereqs-mongodb-svc.mongodb-dev.svc.cluster.local:27017/user-preferences?authSource=admin"` | MongoDB connection string.                                                 |
| `mongo.username`                      | string   | `"user-preferences"`                                   | Username for MongoDB authentication.                                       |
| `mongo.password`                      | string   | `"your.mongo.password.here"`                          | Password for MongoDB authentication.                                       |
| `mongo.database`                      | string   | `"user-preferences"`                                   | Name of the MongoDB database to use.                                       |
| `mongo.existingMongoPasswordSecret`   | string   | `""`                                                  | Name of an existing secret containing the MongoDB password.                |
| `fullnameOverride`                    | string   | `""`                                                  | Override the full name of the chart.                                       |
| `nameOverride`                        | string   | `""`                                                  | Custom name for the chart, not fully qualified.                            |
| `annotations`                         | object   | `{}`                                                  | Additional annotations for the pod.                                        |
| `replicas`                            | integer  | `1`                                                   | Number of replicas.                                                        |
| `resources.requests`                  | object   | `{}`                                                  | Resource requests for the pod.                                             |
| `resources.limits`                    | object   | `{}`                                                  | Resource limits for the pod.                                               |
| `revisionHistoryLimit`                | integer  | `3`                                                   | Number of old ReplicaSets to retain.                                       |
| `image.imagePullSecrets`              | array    | `[]`                                                  | List of secrets to use for pulling the image.                              |
| `image.pullPolicy`                    | string   | `"IfNotPresent"`                                      | Image pull policy.                                                         |
| `image.repository`                    | string   | `"098669589541.dkr.ecr.eu-west-2.amazonaws.com/telicent-user-preferences-service"` | Docker repository for the image.                                           |
| `image.tag`                           | string   | `""`                                                  | Image tag to use.                                                          |
| `podSecurityContext.fsGroup`          | integer  | `185`                                                 | Filesystem group ID for the pod.                                           |
| `podSecurityContext.runAsGroup`       | integer  | `185`                                                 | Group ID for the pod.                                                      |
| `podSecurityContext.runAsNonRoot`     | boolean  | `true`                                                | Ensure the pod runs as a non-root user.                                    |
| `podSecurityContext.runAsUser`        | integer  | `185`                                                 | User ID for the pod.                                                       |
| `podSecurityContext.seccompProfile.type` | string | `"RuntimeDefault"`                                    | Seccomp profile type for the pod.                                          |
| `containerSecurityContext.allowPrivilegeEscalation` | boolean | `false`                                               | Prevent privilege escalation for the container.                            |
| `containerSecurityContext.capabilities.drop` | array | `["ALL"]`                                             | Capabilities to drop for the container.                                    |
| `containerSecurityContext.runAsGroup` | integer  | `185`                                                 | Group ID for the container.                                                |
| `containerSecurityContext.runAsNonRoot` | boolean | `true`                                                | Ensure the container runs as a non-root user.                              |
| `containerSecurityContext.runAsUser`  | integer  | `185`                                                 | User ID for the container.                                                 |
| `containerSecurityContext.seccompProfile.type` | string | `"RuntimeDefault"`                                    | Seccomp profile type for the container.                                    |
| `metrics.service.port`                | integer  | `9464`                                                | Port for the Prometheus service.                                           |
| `serviceAccount.annotations`          | object   | `{}`                                                  | Additional annotations for the service account.                            |
| `serviceAccount.name`                 | string   | `""`                                                  | Name of the service account.                                               |
| `service.port`                        | integer  | `11111`                                               | Port the service will listen on.                                           |
| `service.type`                        | string   | `"ClusterIP"`                                         | Service type.                                                              |

## Usage

To customize the values, create a `values.yaml` file and override the default values as needed.

```bash
helm install my-release ./user-preferences-api -f [values.yaml](http://_vscodecontentref_/1)