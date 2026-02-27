# Telicent Package for Notifications API

**Notifications API** provides REST endpoints for creating and reading notifications. It writes new notifications to the Kafka Notifications Topic and reads them from the Postgres Notifications Database.
## Introduction

This chart bootstraps Notifications deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-preview/charts/notifications
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
 --values=charts/telicent-preview/charts/notifications/values.yaml \
 --readme=charts/telicent-preview/charts/notifications/README.md \
 --schema=charts/telicent-preview/charts/notifications/values.schema.json
```

## Configuration and installation details

### Resource requests and limits

These are inside the `resources` value (check parameter table). Setting requests is essential for production workloads
and these should be adapted to your specific use case.

### Sidecars and Init Containers

If you have a need for additional containers to run within the same pod (e.g. an additional metrics or logging
exporter), you can do so via the `sidecars` config parameter.
Define your container according to the Kubernetes container spec.

```yaml
sidecars:
- name: your-image-name
  image: your-image
  imagePullPolicy: Always
  ports:
  - name: portname
    containerPort: 1234
```

Similarly, you can add extra init containers using the `initContainers` parameter.

```yaml
initContainers:
- name: your-image-name
  image: your-image
  imagePullPolicy: Always
  ports:
  - name: portname
    containerPort: 1234
```

### Setting Pod's affinity

This chart allows you to set your custom affinity using the `affinity` parameter.
Find more information about Pod's affinity in
the [kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity).

## Parameters

### Global Parameters

Contains global parameters; these parameters are mirrored within the Telicent core umbrella chart
Note: Only global parameters used within this chart will be listed below

| Name                                    | Description                                                                                                                     | Value                                            |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| `global.imageRegistry`                  | Global image registry                                                                                                           | `""`                                             |
| `global.imagePullSecrets`               | Global registry secret names as an array                                                                                        | `[]`                                             |
| `global.enterprise`                     | Enable enterprise mode, adding additional features and configurations                                                           | `false`                                          |
| `global.appHostDomain`                  | Domain associated with Telicent application services. This value cannot be changed after it is set                              | `""`                                             |
| `global.apiHostDomain`                  | Domain associated with Telicent Api services. This value cannot be changed after it is set                                      | `""`                                             |
| `global.authHostDomain`                 | Domain associated with Telicent authentication services, including OIDC providers. This value cannot be changed after it is set | `""`                                             |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers                                                                         | `kafka-bootstrap.kafka.svc.cluster.local:9092`   |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration (preferred over individual settings below for security)               | `""`                                             |
| `global.kafka.username`                 | Username for Kafka authentication                                                                                               | `your.kafka.username.here`                       |
| `global.kafka.password`                 | Password for Kafka authentication                                                                                               | `your.kafka.password.here`                       |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                                                                                           | `SASL_SSL`                                       |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication                                                                                    | `SCRAM-SHA-512`                                  |
| `global.truststore.existingSecret`      | Name of an existing secret containing the truststore                                                                            | `""`                                             |
| `global.truststore.mountPath`           | The mount path for the truststore in the container                                                                              | `/app/config/truststore`                         |
| `global.groupsClaim`                    | Key used to retrieve groups from the OIDC provider                                                                              | `groups`                                         |
| `global.jwksUrl`                        | Endpoint exposing multiple public keys represented as JWKs (JSON Web Key Set)                                                   | `https://{yourAuthdomain}/.well-known/jwks.json` |
| `global.istioNamespace`                 | Namespace in which Istio is deployed                                                                                            | `istio-system`                                   |
| `global.istioServiceAccountName`        | Name of the Istio service account                                                                                               | `istio-ingress`                                  |
| `global.istioGatewayName`               | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)                                                       | `ingress-gateway`                                |
| `global.istioVirtualServiceEnabled`     | Enable Istio traffic routing to a named destination service                                                                     | `true`                                           |

### Application Parameters - Kafka

Contains Kafka topic configuration for the *Notifications* application

| Name                              | Description                           | Value               |
| --------------------------------- | ------------------------------------- | ------------------- |
| `notifications.topics.inputTopic` | Topic to consume messages from        | `notifications`     |
| `notifications.topics.dlqTopic`   | Dead-letter topic for failed messages | `notifications.dlq` |

### PostgreSQL

Note: It is recommended to use a Kubernetes secret for sensitive information like passwords

| Name                      | Description                                                                                                                                                     | Value           |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| `postgres.host`           | PostgreSQL connection hostname                                                                                                                                  | `postgres`      |
| `postgres.port`           | PostgreSQL connection port                                                                                                                                      | `5432`          |
| `postgres.name`           | PostgreSQL Database name                                                                                                                                        | `notifications` |
| `postgres.jdbcUrl`        | PostgreSQL connection URI. If specified the postgres.host, postgres.port and postgres.name will be ignored                                                      | `""`            |
| `postgres.username`       | PostgreSQL username                                                                                                                                             | `""`            |
| `postgres.password`       | PostgreSQL password                                                                                                                                             | `""`            |
| `postgres.existingSecret` | Name of an existing secret resource containing the PostgreSQL credentials. If specified, the values for postgres.username and postgres.password will be ignored | `""`            |

### image This sets the container image more information can be found here: https://kubernetes.io/docs/concepts/containers/images/

| Name                | Description                                                                    | Value                                        |
| ------------------- | ------------------------------------------------------------------------------ | -------------------------------------------- |
| `image.registry`    | *Notifications* image registry                                                 | `quay.io`                                    |
| `image.repository`  | *Notifications* image name                                                     | `telicent/telicent-notifications-api-server` |
| `image.tag`         | *Notifications* image tag. If not set, a tag is generated using the appVersion | `""`                                         |
| `image.pullPolicy`  | *Notifications* image pull policy                                              | `IfNotPresent`                               |
| `image.pullSecrets` | Specify registry secret names as an array                                      | `[]`                                         |

### Deployment Parameters For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/

| Name             | Description                                                | Value |
| ---------------- | ---------------------------------------------------------- | ----- |
| `podAnnotations` | Add extra annotations to the Deployment object             | `{}`  |
| `extraEnvs`      | List of additional environment variables to set in the pod | `[]`  |

### Deployment Resources Parameters - Requests and Limits

| Name        | Description                              | Value |
| ----------- | ---------------------------------------- | ----- |
| `resources` | Resources for *Notifications* containers | `{}`  |

### Deployment Security Context Parameters - Default Security Context

| Name                                                | Description                                                             | Value            |
| --------------------------------------------------- | ----------------------------------------------------------------------- | ---------------- |
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

### Deployment Affinity Parameters

| Name           | Description                    | Value |
| -------------- | ------------------------------ | ----- |
| `affinity`     | Affinity for pod assignment    | `{}`  |
| `nodeSelector` | Node labels for pod assignment | `{}`  |
| `tolerations`  | Tolerations for pod assignment | `[]`  |

### Service Account Parameters

| Name                         | Description                                                                           | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                 | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                | `true` |

### Traffic Exposure Parameters

| Name           | Description                                                                      | Value       |
| -------------- | -------------------------------------------------------------------------------- | ----------- |
| `service.name` | *Notifications* service name. If not set, a name is generated using the fullname | `""`        |
| `service.port` | *Notifications* service port                                                     | `8080`      |
| `service.type` | *Notifications* service type                                                     | `ClusterIP` |

### Metrics (Prometheus) Exposure Parameters

| Name                   | Description                     | Value     |
| ---------------------- | ------------------------------- | --------- |
| `metrics.enabled`      | Enable Prometheus metrics       | `true`    |
| `metrics.service.name` | Name for the Prometheus service | `metrics` |
| `metrics.service.port` | Port for the Prometheus service | `9464`    |

### Host(s) Parameters - Contains host information for applications deployed via *telicent-core* chart.

*Notifications* interacts with applications deployed via *telicent-core* using their default service/serviceAccount and port.
If either of those details changes, you can use this section to correctly refer to those applications.

| Name                      | Description                                                                                                                                     | Value                |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | -------------------- |
| `hosts.enableAutoCorrect` | Prefix 'global.releaseNameTelicentCore' value to each host value. Alternatively, the host value will be used as it is, without any modification | `true`               |
| `hosts.auth`              | Auth application default host value, as defined by 'service/serviceAccount:port'                                                                | `auth:8080`          |
| `hosts.traefikProxy`      | Traefik Proxy application default host value, as defined by 'service/serviceAccount:port'                                                       | `traefik-proxy:8080` |

### Validation (Apicurio schema registry) Exposure Parameters

| Name                           | Description                           | Value             |
| ------------------------------ | ------------------------------------- | ----------------- |
| `validation.enabled`           | Enable JSON Schema validation         | `false`           |
| `validation.registry.hostname` | Name for the Apicurio schema registry | `http://apicurio` |
| `validation.registry.port`     | Port for the Apicurio schema registry | `8080`            |

## License

Copyright &copy; 2025 Telicent Limited