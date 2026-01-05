# Telicent Package for Spatial

**Spatial** provides spatial capabilities and a method of resolving geo data from a Kafka Topic.

## Introduction

This chart bootstraps Spatial deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/spatial
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Automating README and schema generation

```bash
.dev/readme-generator-for-helm --config=charts/telicent-core/readme.config \
 --values=charts/telicent-core/charts/spatial/values.yaml \
 --readme=charts/telicent-core/charts/spatial/README.md \
 --schema=charts/telicent-core/charts/spatial/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                                    | Description                                                                                                       | Value                                            |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| `global.imageRegistry`                  | Global image registry                                                                                             | `""`                                             |
| `global.imagePullSecrets`               | Global registry secret names as an array                                                                          | `[]`                                             |
| `global.enterprise`                     | Enable enterprise mode, adding additional features and configurations                                             | `false`                                          |
| `global.appHostDomain`                  | Domain associated with Telicent application services                                                              | `apps.telicent.io`                               |
| `global.authHostDomain`                 | Domain associated with Telicent authentication services, including OIDC providers                                 | `auth.telicent.io`                               |
| `global.groupsClaim`                    | Key used to retrieve groups from the OIDC provider                                                                | `groups`                                         |
| `global.jwksUrl`                        | Endpoint exposing multiple public keys represented as JWKs (JSON Web Key Set)                                     | `https://{yourAuthdomain}/.well-known/jwks.json` |
| `global.istioNamespace`                 | Namespace in which Istio is deployed                                                                              | `istio-system`                                   |
| `global.istioServiceAccountName`        | Name of the Istio service account                                                                                 | `istio-ingress`                                  |
| `global.istioGatewayName`               | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)                                         | `ingress-gateway`                                |
| `global.istioVirtualServiceEnabled`     | Enable Istio traffic routing to a named destination service                                                       | `true`                                           |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers                                                           | `kafka-bootstrap.kafka.svc.cluster.local:9092`   |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration (preferred over individual settings below for security) | `""`                                             |
| `global.kafka.username`                 | Username for Kafka authentication                                                                                 | `your.kafka.username.here`                       |
| `global.kafka.password`                 | Password for Kafka authentication                                                                                 | `your.kafka.password.here`                       |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                                                                             | `SASL_SSL`                                       |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication                                                                      | `SCRAM-SHA-512`                                  |
| `global.truststore.existingSecretName`  | Name of an existing secret containing the truststore                                                              | `""`                                             |
| `global.truststore.mountPath`           | The mount path for the truststore in the container                                                                | `/app/config/truststore`                         |

### configuration

Application specific configuration settings

| Name                        | Description                          | Value |
| --------------------------- | ------------------------------------ | ----- |
| `configuration.sourceTopic` | source topic from which to pull data | `geo` |

### PostgreSQL

Note: It is recommended to use a Kubernetes secret for sensitive information like passwords

| Name                      | Description                                                                                                                                                                                        | Value |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `postgres.uri`            | PostgreSQL connection URL                                                                                                                                                                          | `""`  |
| `postgres.username`       | PostgreSQL username                                                                                                                                                                                | `""`  |
| `postgres.password`       | PostgreSQL password                                                                                                                                                                                | `""`  |
| `postgres.db`             | PostgreSQL Database name                                                                                                                                                                           | `""`  |
| `postgres.existingSecret` | Name of an existing secret resource containing the PostgreSQL password. If specified, existing secret must contain data for POSTGRES_PASSWORD, and the value for postgres.password will be ignored | `""`  |

### image This sets the container image more information can be found here: https://kubernetes.io/docs/concepts/containers/images/

| Name                | Description                                                                | Value                                                                           |
| ------------------- | -------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| `image.registry`    | Auth server image registry                                                 | `quay.io`                                                                       |
| `image.repository`  | Auth server image name                                                     | `098669589541.dkr.ecr.eu-west-2.amazonaws.com/telicent-smart-cache-spatial-api` |
| `image.pullPolicy`  | Auth server image pull policy                                              | `IfNotPresent`                                                                  |
| `image.tag`         | Auth server image tag. If not set, a tag is generated using the appVersion | `""`                                                                            |
| `image.pullSecrets` | Specify registry secret names as an array                                  | `[]`                                                                            |

### Deployment Parameters For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/

| Name                                                | Description                                                             | Value            |
| --------------------------------------------------- | ----------------------------------------------------------------------- | ---------------- |
| `podAnnotations`                                    | Add extra annotations to the Deployment object                          | `{}`             |
| `extraEnvs`                                         | List of additional environment variables to set in the pod              | `[]`             |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID           | `185`            |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID         | `185`            |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                | `true`           |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem | `185`            |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile             | `RuntimeDefault` |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                      | `185`            |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                    | `185`            |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                           | `true`           |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation               | `false`          |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                      | `["ALL"]`        |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                        | `RuntimeDefault` |

### Traffic Exposure Parameters

| Name                        | Description                    | Value       |
| --------------------------- | ------------------------------ | ----------- |
| `service.port`              | Auth server service port       | `8000`      |
| `service.type`              | Auth server service port       | `ClusterIP` |
| `resources.requests.cpu`    | Set containers' CPU request    | `1000m`     |
| `resources.requests.memory` | Set containers' memory request | `4000Mi`    |
| `resources.limits.cpu`      | Set containers' CPU limit      | `2000m`     |
| `resources.limits.memory`   | Set containers' memory limit   | `8000Mi`    |

### Node Selection

| Name           | Description                                                                                                                                    | Value |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `nodeSelector` | Allows you to schedule pods on a node with a label matching the given key-value pair.                                                          | `{}`  |
| `affinity`     | Allows you to define affinity rules for scheduling pods, see: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/         | `{}`  |
| `tolerations`  | ALlows you to schedule pods on nodes with specified taints, see: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ | `[]`  |

### Service Account Parameters

| Name                         | Description                                                                           | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                 | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                | `true` |

### Host(s) Core Parameters - Contains host information for applications deployed via *telicent-core* chart

*Paperback Writer* interacts with applications deployed via *telicent-core* using their default service/serviceAccount and port.
If either of those details changes, you can use this section to correctly refer to those applications.

| Name                          | Description                                                                                                                                     | Value                |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | -------------------- |
| `hostsCore.enableAutoCorrect` | Prefix 'global.releaseNameTelicentCore' value to each host value. Alternatively, the host value will be used as it is, without any modification | `true`               |
| `hostsCore.traefikProxy`      | Traefik Proxy application default host value, as defined by 'service/serviceAccount:port'                                                       | `traefik-proxy:8080` |
| `hostsCore.auth`              | Auth application default host value, as defined by 'service/serviceAccount:port'                                                                | `auth:8080`          |
| `hostsCore.graph`             | Graph application host value, as defined by 'service/serviceAccount:port'                                                                       | `graph:8080`         |

## License

Copyright &copy; 2025 Telicent Limited

