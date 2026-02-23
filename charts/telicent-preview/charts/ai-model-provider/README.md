# Telicent Package for AI Model Provider

**AI Model Provider** provides AI model serving capabilities.

## Introduction

This chart bootstraps AI Model Provider deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-preview/charts/ai-model-provider
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
 --values=charts/telicent-preview/charts/ai-model-provider/values.yaml \
 --readme=charts/telicent-preview/charts/ai-model-provider/README.md \
 --schema=charts/telicent-preview/charts/ai-model-provider/values.schema.json
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

| Name                               | Description                                                                                                                     | Value                    |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `global.imageRegistry`             | Global image registry                                                                                                           | `""`                     |
| `global.imagePullSecrets`          | Global registry secret names as an array                                                                                        | `[]`                     |
| `global.enterprise`                | Enable enterprise mode, adding additional features and configurations                                                           | `false`                  |
| `global.appHostDomain`             | Domain associated with Telicent application/ui services. This value cannot be changed after it is set                           | `""`                     |
| `global.apiHostDomain`             | Domain associated with Telicent Api services. This value cannot be changed after it is set                                      | `""`                     |
| `global.authHostDomain`            | Domain associated with Telicent authentication services, including OIDC providers. This value cannot be changed after it is set | `""`                     |
| `global.truststore.existingSecret` | Name of an existing secret containing the truststore                                                                            | `""`                     |
| `global.truststore.mountPath`      | The mount path for the truststore in the container                                                                              | `/app/config/truststore` |

### Application Parameters - Java

Contains Java configuration parameters to be used by the *AI Model Provider* application

| Name              | Description                     | Value                       |
| ----------------- | ------------------------------- | --------------------------- |
| `java.jvmOptions` | JVM options for the application | `-XX:MaxRAMPercentage=80.0` |

### Application Parameters - Elastic/OpenSearch and Secret

The following contains connection details to an Elastic/OpenSearch service, on which the application relies.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-usr-elastic-search` will be created if one is not set.

| Name                              | Description                                                                        | Value                          |
| --------------------------------- | ---------------------------------------------------------------------------------- | ------------------------------ |
| `elastic.host`                    | Elastic/OpenSearch host                                                            | `https://your.opensearch.host` |
| `elastic.port`                    | Elastic/OpenSearch port number                                                     | `443`                          |
| `elastic.opensearchCompatibility` | Enable OpenSearch compatibility                                                    | `true`                         |
| `elastic.index`                   | Elastic/OpenSearch index to be used                                                | `search,doc-content`           |
| `elastic.searchFieldOptions`      | Field options for search                                                           | `primaryName^2,*`              |
| `elastic.indexBatchSize`          | Number of documents to index in a single batch operation                           | `100`                          |
| `elastic.existingSecret`          | Name of an existing secret. The secret must contain 2 keys: 'username', 'password' | `""`                           |
| `elastic.username`                | OpenSearch/Elastic username                                                        | `""`                           |
| `elastic.password`                | OpenSearch/Elastic user password                                                   | `""`                           |

### ConfigMap Parameters

Contains configuration parameters specific to the *AI Model Provider* application

| Name                             | Description                                                              | Value |
| -------------------------------- | ------------------------------------------------------------------------ | ----- |
| `configMap.existingEnvConfigMap` | Name of existing configmap containing *AI Model Provider* Environment Configuration | `""`  |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                   | Description                                                   | Value |
| ---------------------- | ------------------------------------------------------------- | ----- |
| `replicas`             | Number of *AI Model Provider* replicas to deploy                         | `1`   |
| `revisionHistoryLimit` | Number of controller revisions to keep                        | `5`   |
| `annotations`          | Add extra annotations to the deployment object                | `{}`  |
| `podLabels`            | Add extra labels to the *AI Model Provider* pod                          | `{}`  |
| `podAnnotations`       | Add extra annotations to the *AI Model Provider* pod                     | `{}`  |
| `extraEnvVars`         | Array with extra environment variables to add to *AI Model Provider* pod | `[]`  |
| `extraVolumes`         | Additional containers to be added to the *AI Model Provider* pod         | `[]`  |
| `extraVolumeMounts`    | Optionally specify extra list of additional volumeMounts      | `[]`  |
| `initContainers`       | Add init containers to the pod                                | `[]`  |
| `sidecars`             | Add sidecars to the pod                                       | `[]`  |

### Deployment Image Parameters

| Name                | Description                                                             | Value                        |
| ------------------- | ----------------------------------------------------------------------- | ---------------------------- |
| `image.registry`    | *AI Model Provider* image registry                                                 | `quay.io`                    |
| `image.repository`  | *AI Model Provider* image name                                                     | `telicent/ai-model-provider` |
| `image.tag`         | *AI Model Provider* image tag. If not set, a tag is generated using the appVersion | `""`                         |
| `image.pullPolicy`  | *AI Model Provider* image pull policy                                              | `IfNotPresent`               |
| `image.pullSecrets` | Specify registry secret names as an array                               | `[]`                         |

### Deployment Resources Parameters - Requests and Limits

| Name        | Description                       | Value |
| ----------- | --------------------------------- | ----- |
| `resources` | Resources for *AI Model Provider* containers | `{}`  |

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

| Name           | Description                                                               | Value       |
| -------------- | ------------------------------------------------------------------------- | ----------- |
| `service.name` | *AI Model Provider* service name. If not set, a name is generated using the fullname | `""`        |
| `service.port` | *AI Model Provider* service port                                                     | `8080`      |
| `service.type` | *AI Model Provider* service port                                                     | `ClusterIP` |

### Metrics (Prometheus) Exposure Parameters

| Name                   | Description                     | Value     |
| ---------------------- | ------------------------------- | --------- |
| `metrics.enabled`      | Enable Prometheus metrics       | `true`    |
| `metrics.service.name` | Name for the Prometheus service | `metrics` |
| `metrics.service.port` | Port for the Prometheus service | `9464`    |

### Host(s) Parameters - Contains host information for applications deployed via *telicent-core* chart.

*AI Model Provider* interacts directly with other Telicent Applications using their default service/serviceAccount and port.
If either of those details changes, you can use this section to correctly refer to those apps.

| Name                      | Description                                                                                                                                                                                                                          | Value                |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------- |
| `hosts.enableAutoCorrect` | Allow for the release name to be automatically pre-fixed to each host value when required (default behavior when installing through the parent chart). Alternatively, the host value will be used as it is, without any modification | `true`               |
| `hosts.auth`              | Auth application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                                     | `auth:8080`          |
| `hosts.traefikProxy`      | Traefik Proxy application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                            | `traefik-proxy:8080` |
| `hosts.graph`             | Graph application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                                    | `graph:8080`         |

## License

Copyright &copy; 2025 Telicent Limited