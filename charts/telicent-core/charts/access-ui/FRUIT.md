# Access API Helm Chart

This Helm chart deploys the Access API application. Below is a list of all configurable values in the `values.yaml` file.

## Parameters

### Global parameters

This section contains global values that are used across the charts inherited from the telicent core umbrella chart,
Please, note override these values

| Name                    | Description                                                                                       | Value              |
| ----------------------- | ------------------------------------------------------------------------------------------------- | ------------------ |
| `global.appHostDomain`  | Domain name associated with this application                                                      | `apps.telicent.io` |
| `global.authHostDomain` | Domain to be used for interacting with Telicent authentication services, including OIDC providers | `auth.telicent.io` |

### Configuration parameters

Telicent specific settings
This section contains configuration options specific to this Telicent application

| Name                              | Description                     | Value                      |
| --------------------------------- | ------------------------------- | -------------------------- |
| `configuration.debug`             | enables debug logging           | `true`                     |
| `configuration.openidProviderUrl` | is the URL of the OIDC provider | `https://oidc.example.com` |
| `configuration.scimEnabled`       | enables SCIM user management    | `true`                     |

### Common parameters

| Name                                                | Description                                                        | Value                                         |
| --------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------------- |
| `existingConfigmap`                                 | String is the name of the existing configmap for configuration     | `""`                                          |
| `existingCacertConfigmap`                           | is the name of the existing configmap for extra certificates       | `""`                                          |
| `fullnameOverride`                                  | sets the full name of the chart                                    | `""`                                          |
| `cacert`                                            | is the path to the CA certificate file                             | `""`                                          |
| `containerSecurityContext.allowPrivilegeEscalation` | prevents privilege escalation                                      | `false`                                       |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                 | `["ALL"]`                                     |
| `containerSecurityContext.runAsGroup`               | sets the group ID for the container                                | `185`                                         |
| `containerSecurityContext.runAsNonRoot`             | ensures the container runs as a non-root user                      | `true`                                        |
| `containerSecurityContext.runAsUser`                | sets the user ID for the container                                 | `185`                                         |
| `containerSecurityContext.seccompProfile.type`      | defines the seccomp profile type                                   | `RuntimeDefault`                              |
| `image.imagePullSecrets`                            | is a list of secrets to use for pulling the image                  | `[]`                                          |
| `image.pullPolicy`                                  | defines the image pull policy                                      | `Always`                                      |
| `image.repository`                                  | is the Docker repository for the image                             | `telicent/telicent-access-api`                |
| `image.tag`                                         | is the image tag to use                                            | `""`                                          |
| `mongo.url`                                         | is the MongoDB connection URL                                      | `mongodb://example.mongodb.net`               |
| `mongo.username`                                    | is the MongoDB username                                            | `root`                                        |
| `mongo.password`                                    | is the MongoDB password                                            | `your.mongo.password.here`                    |
| `mongo.collection`                                  | is the MongoDB collection to use                                   | `access`                                      |
| `mongo.connectionStringOptions`                     | are additional options for the MongoDB connection string           | `authMechanism=SCRAM-SHA-1&retryWrites=false` |
| `mongo.retryRewrites`                               | enables or disables retryable writes                               | `false`                                       |
| `mongo.existingMongoPasswordSecret`                 | is the name of the existing secret containing the MongoDB password | `""`                                          |
| `podSecurityContext.fsGroup`                        | sets the filesystem group ID for the pod                           | `185`                                         |
| `podSecurityContext.runAsGroup`                     | sets the group ID for the pod                                      | `185`                                         |
| `podSecurityContext.runAsNonRoot`                   | ensures the pod runs as a non-root user                            | `true`                                        |
| `podSecurityContext.runAsUser`                      | sets the user ID for the pod                                       | `185`                                         |
| `podSecurityContext.seccompProfile.type`            | Set pod's Security Context seccomp profile                         | `RuntimeDefault`                              |
| `replicas`                                          | sets the replica count                                             | `1`                                           |
| `resources.requests.cpu`                            | is the minimum CPU required unit is milliCPU                       | `500m`                                        |
| `resources.requests.memory`                         | is the minimum memory required                                     | `512Mi`                                       |
| `resources.limits.cpu`                              | is the maximum CPU allowed unit is milliCPU                        | `1`                                           |
| `resources.limits.memory`                           | is the maximum memory allowed                                      | `1Gi`                                         |
| `revisionHistoryLimit`                              | sets the number of old ReplicaSets to retain                       | `5`                                           |
| `service.port`                                      | is the port the service will listen on                             | `8080`                                        |
| `service.type`                                      | defines the service type                                           | `ClusterIP`                                   |
| `serviceAccount.annotations`                        | are additional annotations for the service account                 | `{}`                                          |
| `serviceAccount.name`                               | is the name of the service account                                 | `""`                                          |
