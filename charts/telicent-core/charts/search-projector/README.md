# Telicent Package for Search Projector

The **Projector** is responsible for ingesting and indexing data into the search engine, ensuring that Search has up-to-date information to serve queries.

## Introduction

This chart bootstraps Telicent Search Projector deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/search-projector
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
 --values=charts/telicent-core/charts/search-projector/values.yaml \
 --readme=charts/telicent-core/charts/search-projector/README.md \
 --schema=charts/telicent-core/charts/search-projector/values.schema.json
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

| Name                                    | Description                                               | Value                                          |
| --------------------------------------- | --------------------------------------------------------- | ---------------------------------------------- |
| `global.imageRegistry`                  | Global image registry                                     | `""`                                           |
| `global.imagePullSecrets`               | Global registry secret names as an array                  | `[]`                                           |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers   | `kafka-bootstrap.kafka.svc.cluster.local:9092` |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration | `""`                                           |
| `global.kafka.username`                 | Username for Kafka authentication                         | `your.kafka.username.here`                     |
| `global.kafka.password`                 | Password for Kafka authentication                         | `your.kafka.password.here`                     |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                     | `SASL_SSL`                                     |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication              | `SCRAM-SHA-512`                                |
| `global.truststore.existingSecret`      | Name of an existing secret containing the truststore      | `""`                                           |
| `global.truststore.mountPath`           | The mount path for the truststore in the container        | `/app/config/truststore`                       |

### ConfigMap Parameters

Contains configuration parameters specific to the *Search Projector* application

| Name                             | Description                                                                        | Value |
| -------------------------------- | ---------------------------------------------------------------------------------- | ----- |
| `configMap.existingEnvConfigMap` | Name of existing configmap containing *Search Projector* Environment Configuration | `""`  |

### Java Parameters

Contains Java configuration parameters to be used by the *Search Projector* application

| Name              | Description                     | Value                       |
| ----------------- | ------------------------------- | --------------------------- |
| `java.jvmOptions` | JVM options for the application | `-XX:MaxRAMPercentage=80.0` |

### Elastic/OpenSearch Parameters and Secret

The following contains connection details to an Elastic/OpenSearch service, on which the application relies.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-usr-elastic-search-projector` will be created if one is not set.

| Name                              | Description                                                                        | Value                          |
| --------------------------------- | ---------------------------------------------------------------------------------- | ------------------------------ |
| `elastic.host`                    | Elastic/OpenSearch host                                                            | `https://your.opensearch.host` |
| `elastic.port`                    | Elastic/OpenSearch cluster port                                                    | `443`                          |
| `elastic.opensearchCompatibility` | Enable OpenSearch compatibility                                                    | `true`                         |
| `elastic.index`                   | Elastic/OpenSearch index to be used                                                | `search`                       |
| `elastic.topic`                   | Topic to consume messages from                                                     | `knowledge`                    |
| `elastic.dlqTopic`                | Dead-letter topic for failed messages                                              | `knowledge.dlq`                |
| `elastic.indexBatchSize`          | Number of documents to index in a single batch operation                           | `500`                          |
| `elastic.existingSecret`          | Name of an existing secret. The secret must contain 2 keys: 'username', 'password' | `""`                           |
| `elastic.username`                | OpenSearch/Elastic username                                                        | `""`                           |
| `elastic.password`                | OpenSearch/Elastic user password                                                   | `""`                           |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                                                | Description                                                                       | Value                                       |
| --------------------------------------------------- | --------------------------------------------------------------------------------- | ------------------------------------------- |
| `replicas`                                          | Number of *Search Projector* replicas to deploy                                   | `1`                                         |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                            | `5`                                         |
| `annotations`                                       | Add extra annotations to the deployment object                                    | `{}`                                        |
| `podLabels`                                         | Add extra labels to the *Search Projector* pod                                    | `{}`                                        |
| `podAnnotations`                                    | Add extra annotations to the *Search Projector* pod                               | `{}`                                        |
| `extraEnvVars`                                      | Array with extra environment variables to add to *Search Projector* pod           | `[]`                                        |
| `extraVolumes`                                      | Additional containers to be added to the *Search Projector* pod                   | `[]`                                        |
| `extraVolumeMounts`                                 | Optionally specify extra list of additional volumeMounts                          | `[]`                                        |
| `initContainers`                                    | Add init containers to the pod                                                    | `[]`                                        |
| `sidecars`                                          | Add sidecars to the pod.                                                          | `[]`                                        |
| `image.registry`                                    | *Search Projector* image registry                                                 | `REGISTRY_NAME`                             |
| `image.repository`                                  | *Search Projector* image name                                                     | `REPOSITORY_NAME/smart-cache-elastic-index` |
| `image.tag`                                         | *Search Projector* image tag. If not set, a tag is generated using the appVersion | `""`                                        |
| `image.pullPolicy`                                  | *Search Projector* image pull policy                                              | `IfNotPresent`                              |
| `image.pullSecrets`                                 | Specify registry secret names as an array                                         | `[]`                                        |
| `resources.requests.cpu`                            | Set containers' CPU request                                                       | `250m`                                      |
| `resources.requests.memory`                         | Set containers' memory request                                                    | `1000Mi`                                    |
| `resources.limits.cpu`                              | Set containers' CPU limit                                                         | `500m`                                      |
| `resources.limits.memory`                           | Set containers' memory limit                                                      | `2000Mi`                                    |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                                | `185`                                       |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                              | `185`                                       |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                                     | `true`                                      |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                         | `false`                                     |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                                | `["ALL"]`                                   |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                                  | `RuntimeDefault`                            |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID                     | `185`                                       |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID                   | `185`                                       |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                          | `true`                                      |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem           | `185`                                       |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile                       | `RuntimeDefault`                            |
| `affinity`                                          | Affinity for pod assignment                                                       | `{}`                                        |
| `nodeSelector`                                      | Node labels for pod assignment                                                    | `{}`                                        |
| `tolerations`                                       | Tolerations for pod assignment                                                    | `[]`                                        |

### Service Account Parameters

| Name                         | Description                                                                           | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                 | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                | `true` |

### Traffic Exposure Parameters

| Name           | Description                                                                         | Value       |
| -------------- | ----------------------------------------------------------------------------------- | ----------- |
| `service.name` | *Search Projector* service name. If not set, a name is generated using the fullname | `""`        |
| `service.type` | *Search Projector* service type                                                     | `ClusterIP` |

### Metrics (Prometheus) Exposure Parameters

| Name                   | Description                     | Value     |
| ---------------------- | ------------------------------- | --------- |
| `metrics.enabled`      | Enable Prometheus metrics       | `true`    |
| `metrics.service.name` | Name for the Prometheus service | `metrics` |
| `metrics.service.port` | Port for the Prometheus service | `9464`    |

## License

Copyright &copy; 2025 Telicent Limited