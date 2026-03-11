# Telicent GRPC Client

Telicent Data Preparation is a Kafka Streams application that filters and transforms messages before they enter the data sharing pipeline.

## Introduction

This chart bootstraps Telicent Data Preparation deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-data-sink/data-preparation
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
 --values=charts/telicent-data-sink/data-preparation/values.yaml \
 --readme=charts/telicent-data-sink/data-preparation/README.md \
 --schema=charts/telicent-data-sink/data-preparation/values.schema.json
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

Contains global parameters; these parameters are mirrored within the Telicent umbrella charts.
Note: Only global parameters used within this chart will be listed below.

| Name                                    | Description                                               | Value                                          |
| --------------------------------------- | --------------------------------------------------------- | ---------------------------------------------- |
| `global.imageRegistry`                  | Global image registry                                     | `""`                                           |
| `global.imagePullSecrets`               | Global registry secret names as an array                  | `[]`                                           |
| `global.enabled`                        | enabled Enable *Data Preparation* deployment              | `false`                                        |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers   | `kafka-bootstrap.kafka.svc.cluster.local:9092` |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration | `""`                                           |
| `global.kafka.username`                 | Username for Kafka authentication                         | `your.kafka.username.here`                     |
| `global.kafka.password`                 | Password for Kafka authentication                         | `your.kafka.password.here`                     |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                     | `SASL_SSL`                                     |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication              | `SCRAM-SHA-512`                                |

### Application Parameters - Engine

Contains parameters specific to the *Data Preparation* application

| Name                                        | Description                                                                          | Value   |
| ------------------------------------------- | ------------------------------------------------------------------------------------ | ------- |
| `engine.applicationId`                      | Kafka Streams application ID (required)                                              | `""`    |
| `engine.kafka.inputTopic`                   | Input topic to consume from (required)                                               | `""`    |
| `engine.kafka.outputTopic`                  | Output topic to produce to (required)                                                | `""`    |
| `engine.kafka.dlqTopic`                     | Dead letter queue topic for failed messages (required)                               | `""`    |
| `engine.filter.enableIDH`                   | Enable filtering messages using Identity-Derived Header (IDH) security labels        | `false` |
| `engine.filter.client.version`              | IDH specification version (required when enableIDH)                                  | `""`    |
| `engine.filter.client.classification`       | Security classification level required when enableIDH)                               | `""`    |
| `engine.filter.client.nationality`          | Space-separated nationality codes; empty = no restriction (optional when enableIDH)  | `""`    |
| `engine.filter.client.organisation`         | Space-separated organisation codes; empty = no restriction (optional when enableIDH) | `""`    |
| `engine.filter.client.group`                | Space-separated group names; empty = no restriction (optional when enableIDH)        | `""`    |
| `engine.filter.enableHeaders`               | Enable filtering messages by header values                                           | `false` |
| `engine.filter.headers.include`             |                                                                                      | `[]`    |
| `engine.filter.headers.exclude`             |                                                                                      | `[]`    |
| `engine.transformer.distributionId.enabled` | Enable to add a Distribution-Id header to every message.                             | `false` |
| `engine.transformer.distributionId.id`      | The id value to add to every message header                                          | `""`    |
| `engine.enabledPassthrough`                 | Allow passthrough with no filter or transformer                                      | `false` |

### Application Parameters - Java

Contains Java parameters to be used by the *Data Preparation* application

| Name              | Description                     | Value                       |
| ----------------- | ------------------------------- | --------------------------- |
| `java.jvmOptions` | JVM options for the application | `-XX:MaxRAMPercentage=80.0` |

### Application Parameters - Logs

| Name               | Description                                                                                                                                                                                                                                                               | Value  |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| `logs.root.level`  | Sets the baseline log level. Only warnings and errors from third-party libraries (gRPC, Netty, Flyway, etc.) are logged by default. Values include: ERROR, WARN, INFO, DEBUG, TRACE                                                                                       | `WARN` |
| `logs.app.level`   | Controls log verbosity for all application code. Set to DEBUG for detailed troubleshooting. Values include: ERROR, WARN, INFO, DEBUG, TRACE                                                                                                                               | `INFO` |
| `logs.kafka.level` | Repo package Logging Level. ontrols Kafka client logging independently. Kafka clients are particularly verbose at INFO, so this defaults to WARN. Set to INFO or DEBUG to diagnose connectivity or consumer group issues. Values include: ERROR, WARN, INFO, DEBUG, TRACE | `WARN` |

### ConfigMap Parameters

| Name                             | Description                                                                        | Value |
| -------------------------------- | ---------------------------------------------------------------------------------- | ----- |
| `configMap.existingEnvConfigMap` | Name of existing configmap containing *Data Preparation* Environment Configuration | `""`  |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                   | Description                                                             | Value |
| ---------------------- | ----------------------------------------------------------------------- | ----- |
| `replicas`             | Number of *Data Preparation* replicas to deploy                         | `1`   |
| `revisionHistoryLimit` | Number of controller revisions to keep                                  | `5`   |
| `annotations`          | Add extra annotations to the deployment object                          | `{}`  |
| `podLabels`            | Add extra labels to the *Data Preparation* pod                          | `{}`  |
| `podAnnotations`       | Add extra annotations to the *Data Preparation* pod                     | `{}`  |
| `extraEnvVars`         | Array with extra environment variables to add to *Data Preparation* pod | `[]`  |
| `extraVolumes`         | Optionally specify extra list of additional volumes                     | `[]`  |
| `extraVolumeMounts`    | Optionally specify extra list of additional volumeMounts                | `[]`  |
| `initContainers`       | Add init containers to the pod                                          | `[]`  |
| `sidecars`             | Add sidecars to the pod                                                 | `[]`  |

### Deployment Image Parameters

| Name                | Description                                                                       | Value                       |
| ------------------- | --------------------------------------------------------------------------------- | --------------------------- |
| `image.registry`    | *Data Preparation* image registry                                                 | `quay.io`                   |
| `image.repository`  | *Data Preparation* image name                                                     | `telicent/data-preparation` |
| `image.tag`         | *Data Preparation* image tag. If not set, a tag is generated using the appVersion | `""`                        |
| `image.pullPolicy`  | *Data Preparation* image pull policy                                              | `IfNotPresent`              |
| `image.pullSecrets` | Specify registry secret names as an array                                         | `[]`                        |

### Deployment Resources Parameters - Requests and Limits

| Name        | Description                                 | Value |
| ----------- | ------------------------------------------- | ----- |
| `resources` | Resources for *Data Preparation* containers | `{}`  |

### Statefulset Security Context Parameters - Default Security Context

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
| `affinity`                                          | Affinity for pod assignment                                             | `{}`             |
| `nodeSelector`                                      | Node labels for pod assignment                                          | `{}`             |
| `tolerations`                                       | Tolerations for pod assignment                                          | `[]`             |

### Service Account Parameters

| Name                         | Description                                                                           | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                 | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                | `true` |


## License

Copyright &copy; 2026 Telicent Limited
