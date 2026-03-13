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

Contains global parameters; these parameters are mirrored within the Telicent preview umbrella chart.
Note: Only global parameters used within this chart will be listed below.

| Name                                    | Description                                                                                                                                 | Value                                          |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `global.imageRegistry`                  | Global image registry                                                                                                                       | `""`                                           |
| `global.imagePullSecrets`               | Global registry secret names as an array                                                                                                    | `[]`                                           |
| `global.enabled`                        | enabled Enable *Notifications Projector* deployment                                                                                         | `false`                                        |
| `global.releaseNameTelicentCore`        | Release name used during the Telicent Core chart installation. Note: ensure the value is correct, otherwise there will be no access to auth | `""`                                           |
| `global.appHostDomain`                  | Domain associated with Telicent application/ui services. This value cannot be changed after it is set                                       | `""`                                           |
| `global.apiHostDomain`                  | Domain associated with Telicent Api services. This value cannot be changed after it is set                                                  | `""`                                           |
| `global.authHostDomain`                 | Domain associated with Telicent authentication services, including OIDC providers. This value cannot be changed after it is set             | `""`                                           |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers                                                                                     | `kafka-bootstrap.kafka.svc.cluster.local:9092` |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration (preferred over individual settings below for security)                           | `""`                                           |
| `global.kafka.username`                 | Username for Kafka authentication                                                                                                           | `your.kafka.username.here`                     |
| `global.kafka.password`                 | Password for Kafka authentication                                                                                                           | `your.kafka.password.here`                     |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                                                                                                       | `SASL_SSL`                                     |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication                                                                                                | `SCRAM-SHA-512`                                |
| `global.truststore.existingSecret`      | Name of an existing secret containing the truststore                                                                                        | `""`                                           |
| `global.truststore.mountPath`           | The mount path for the truststore in the container                                                                                          | `/app/config/truststore`                       |

### Application Parameters - Kafka

Contains Kafka topic configuration for the *Notifications* application

| Name                              | Description                           | Value               |
| --------------------------------- | ------------------------------------- | ------------------- |
| `notifications.topics.inputTopic` | Topic to consume messages from        | `notifications`     |
| `notifications.topics.dlqTopic`   | Dead-letter topic for failed messages | `notifications.dlq` |

### Application Parameters - Validation (Apicurio schema registry)

| Name                           | Description                           | Value             |
| ------------------------------ | ------------------------------------- | ----------------- |
| `validation.enabled`           | Enable JSON Schema validation         | `false`           |
| `validation.registry.hostname` | Name for the Apicurio schema registry | `http://apicurio` |
| `validation.registry.port`     | Port for the Apicurio schema registry | `8080`            |

### Application Parameters - PostgreSQL and Secret

The following contains connection details to a PostgreSQL instance, on which the application relies.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-usr-psql-notifications` will be created if one is not set.

| Name                      | Description                                                                        | Value |
| ------------------------- | ---------------------------------------------------------------------------------- | ----- |
| `postgres.jdbcUrl`        | PostgreSQL connection URL format: "jdbc:postgresql://{host}:{port}/{database}"     | `""`  |
| `postgres.existingSecret` | Name of an existing secret. The secret must contain 2 keys: 'username', 'password' | `""`  |
| `postgres.username`       | PostgreSQL username                                                                | `""`  |
| `postgres.password`       | PostgreSQL password                                                                | `""`  |

### ConfigMap Parameters

Contains configuration parameters specific to the *Notifications* application

| Name                             | Description                                                                     | Value |
| -------------------------------- | ------------------------------------------------------------------------------- | ----- |
| `configMap.existingEnvConfigMap` | Name of existing configmap containing *Notifications* Environment Configuration | `""`  |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                   | Description                                                          | Value |
| ---------------------- | -------------------------------------------------------------------- | ----- |
| `replicas`             | Number of *Notifications* replicas to deploy                         | `1`   |
| `revisionHistoryLimit` | Number of controller revisions to keep                               | `5`   |
| `annotations`          | Add extra annotations to the deployment object                       | `{}`  |
| `podLabels`            | Add extra labels to the *Notifications* pod                          | `{}`  |
| `podAnnotations`       | Add extra annotations to the *Notifications* pod                     | `{}`  |
| `extraEnvVars`         | Array with extra environment variables to add to *Notifications* pod | `[]`  |
| `extraVolumes`         | Optionally specify extra list of additional volumes                  | `[]`  |
| `extraVolumeMounts`    | Optionally specify extra list of additional volumeMounts             | `[]`  |
| `initContainers`       | Add init containers to the pod                                       | `[]`  |
| `sidecars`             | Add sidecars to the pod                                              | `[]`  |

### Deployment Image Parameters

| Name                | Description                                                                    | Value                                        |
| ------------------- | ------------------------------------------------------------------------------ | -------------------------------------------- |
| `image.registry`    | *Notifications* image registry                                                 | `quay.io`                                    |
| `image.repository`  | *Notifications* image name                                                     | `telicent/telicent-notifications-api-server` |
| `image.tag`         | *Notifications* image tag. If not set, a tag is generated using the appVersion | `""`                                         |
| `image.pullPolicy`  | *Notifications* image pull policy                                              | `IfNotPresent`                               |
| `image.pullSecrets` | Specify registry secret names as an array                                      | `[]`                                         |

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

### Host(s) Core Parameters - Contains host information for applications deployed via *telicent-core* chart

*Notifications* interacts with applications deployed via *telicent-core* using their default service/serviceAccount and port.
If either of those details changes, you can use this section to correctly refer to those applications.

| Name                          | Description                                                                                                                                     | Value                |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | -------------------- |
| `hostsCore.enableAutoCorrect` | Prefix 'global.releaseNameTelicentCore' value to each host value. Alternatively, the host value will be used as it is, without any modification | `true`               |
| `hostsCore.traefikProxy`      | Traefik Proxy application default host value, as defined by 'service/serviceAccount:port'                                                       | `traefik-proxy:8080` |
| `hostsCore.auth`              | Auth application default host value, as defined by 'service/serviceAccount:port'                                                                | `auth:8080`          |

## License

Copyright &copy; 2026 Telicent Limited