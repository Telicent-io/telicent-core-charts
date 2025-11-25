# Telicent Package for Graph

Telicent Graph enables efficient storage, retrieval, and querying of complex relationships, making it ideal for applications that require rapid access to interconnected datasets.

## Introduction

This chart bootstraps Telicent Graph deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/graph
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
 --values=charts/telicent-core/charts/graph/values.yaml \
 --readme=charts/telicent-core/charts/graph/README.md \
 --schema=charts/telicent-core/charts/graph/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                                    | Description                                                                                                       | Value                                          |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `global.imageRegistry`                  | Global image registry                                                                                             | `""`                                           |
| `global.imagePullSecrets`               | Global registry secret names as an array                                                                          | `[]`                                           |
| `global.enterprise`                     | Enable enterprise mode, adding additional features and configurations                                             | `false`                                        |
| `global.appHostDomain`                  | Domain associated with Telicent application/ui services                                                           | `apps.telicent.io`                             |
| `global.apiHostDomain`                  | Domain associated with Telicent Api services                                                                      | `api.telicent.io`                              |
| `global.authHostDomain`                 | Domain associated with Telicent authentication services, including OIDC providers                                 | `auth.telicent.io`                             |
| `global.istioNamespace`                 | Namespace in which Istio is deployed                                                                              | `istio-system`                                 |
| `global.istioServiceAccountName`        | Name of the Istio service account                                                                                 | `istio-ingress`                                |
| `global.istioGatewayName`               | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)                                         | `ingress-gateway`                              |
| `global.istioVirtualServiceEnabled`     | Enable Istio traffic routing to a named destination service                                                       | `false`                                        |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers                                                           | `kafka-bootstrap.kafka.svc.cluster.local:9092` |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration (preferred over individual settings below for security) | `""`                                           |
| `global.kafka.username`                 | Username for Kafka authentication                                                                                 | `your.kafka.username.here`                     |
| `global.kafka.password`                 | Password for Kafka authentication                                                                                 | `your.kafka.password.here`                     |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                                                                             | `SASL_SSL`                                     |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication                                                                      | `SCRAM-SHA-512`                                |
| `global.truststore.existingSecretName`  | Name of an existing secret containing the truststore                                                              | `""`                                           |
| `global.truststore.mountPath`           | The mount path for the truststore in the container                                                                | `/app/config/truststore`                       |

### Configuration Parameters

Contains configuration parameters specific to the *Graph* application

| Name                                    | Description                                                             | Value                       |
| --------------------------------------- | ----------------------------------------------------------------------- | --------------------------- |
| `configuration.existingEnvConfigMap`    | Name of existing configmap containing *Graph* Environment Configuration | `""`                        |
| `configuration.existingFusekiConfigMap` | Name of existing configmap containing Fuseki Configuration              | `""`                        |
| `configuration.userAttributesUrl`       | URL for the user details endpoint                                       | `""`                        |
| `configuration.attributeHierarchyUrl`   | URL for the user hierarchy endpoint                                     | `""`                        |
| `configuration.javaOptions`             | JVM options for the application                                         | `-XX:MaxRAMPercentage=80.0` |
| `configuration.otelMetricsExporter`     | OpenTelemetry metrics exporter                                          | `prometheus`                |
| `configuration.otelTracesExporter`      | OpenTelemetry traces exporter                                           | `none`                      |
| `configuration.enableLabelsQuery`       | Enable labels query endpoint                                            | `true`                      |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Statefulset Parameters

| Name                                                | Description                                                             | Value                               |
| --------------------------------------------------- | ----------------------------------------------------------------------- | ----------------------------------- |
| `replicas`                                          | Number of *Graph* replicas to deploy                                    | `1`                                 |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                  | `5`                                 |
| `annotations`                                       | Add extra annotations to the Statefulset object                         | `{}`                                |
| `podLabels`                                         | Add extra labels to the *Graph* pod                                     | `{}`                                |
| `podAnnotations`                                    | Add extra annotations to the *Graph* pod                                | `{}`                                |
| `extraEnvVars`                                      | Array with extra environment variables to add to *Graph* pod            | `[]`                                |
| `extraVolumes`                                      | Additional containers to be added to the *Graph* pod                    | `[]`                                |
| `extraVolumeMounts`                                 | Optionally specify extra list of additional volumeMounts                | `[]`                                |
| `initContainers`                                    | Add init containers to the pod                                          | `[]`                                |
| `sidecars`                                          | Add sidecars to the pod.                                                | `[]`                                |
| `image.registry`                                    | *Graph* image registry                                                  | `REGISTRY_NAME`                     |
| `image.repository`                                  | *Graph* image name                                                      | `REPOSITORY_NAME/smart-cache-graph` |
| `image.tag`                                         | *Graph* image tag. If not set, a tag is generated using the appVersion  | `""`                                |
| `image.pullPolicy`                                  | *Graph* image pull policy                                               | `IfNotPresent`                      |
| `image.pullSecrets`                                 | Specify registry secret names as an array                               | `[]`                                |
| `resources.requests.cpu`                            | Set containers' CPU request                                             | `1000m`                             |
| `resources.requests.memory`                         | Set containers' memory request                                          | `8000Mi`                            |
| `resources.limits.cpu`                              | Set containers' CPU limit                                               | `1500m`                             |
| `resources.limits.memory`                           | Set containers' memory limit                                            | `12000Mi`                           |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                      | `185`                               |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                    | `185`                               |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                           | `true`                              |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation               | `false`                             |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                      | `["ALL"]`                           |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                        | `RuntimeDefault`                    |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID           | `185`                               |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID         | `185`                               |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                | `true`                              |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem | `185`                               |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile             | `RuntimeDefault`                    |
| `affinity`                                          | Affinity for pod assignment                                             | `{}`                                |
| `nodeSelector`                                      | Node labels for pod assignment                                          | `{}`                                |
| `tolerations`                                       | Tolerations for pod assignment                                          | `[]`                                |

### Persistent Volume Claim Parameters

| Name                                                 | Description                                    | Value  |
| ---------------------------------------------------- | ---------------------------------------------- | ------ |
| `persistentVolumeClaims.backupsVolume.size`          | PVC Storage Request for the Backup volume      | `25Gi` |
| `persistentVolumeClaims.backupsVolume.storageClass`  | PVC Storage Class for the Backup data volume   | `gp3`  |
| `persistentVolumeClaims.datasetsVolume.size`         | PVC Storage Request for the *Graph* volume     | `25Gi` |
| `persistentVolumeClaims.datasetsVolume.storageClass` | iPVC Storage Class for the *Graph* data volume | `gp3`  |

### Service Account Parameters

| Name                         | Description                                                                           | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                 | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                | `true` |

### Traffic Exposure Parameters

| Name           | Description                                                              | Value       |
| -------------- | ------------------------------------------------------------------------ | ----------- |
| `service.name` | *Graph* service name. If not set, a name is generated using the fullname | `""`        |
| `service.port` | *Graph* service port                                                     | `8080`      |
| `service.type` | *Graph* service type                                                     | `ClusterIP` |

### Metrics (Prometheus) Exposure Parameters

| Name                   | Description                     | Value     |
| ---------------------- | ------------------------------- | --------- |
| `metrics.enabled`      | Enable Prometheus metrics       | `true`    |
| `metrics.service.name` | Name for the Prometheus service | `metrics` |
| `metrics.service.port` | Port for the Prometheus service | `9464`    |

### Istio Parameters

| Name                                       | Description                                                                                                                                                       | Value              |
| ------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------ |
| `istio.ingress.principal`                  | Principal used for ingress traffic by the Istio AuthorizationPolicy.  If not set, a principal is generated using Release namespace and serviceAccountName         | `""`               |
| `istio.ingress.serviceAccountName`         | Name of the Ingress service account (traefik and istio supported)                                                                                                 | `traefik-proxy`    |
| `istio.paperbackWriter.principal`          | Principal used for Paperback Writer traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using Release namespace and serviceAccountName | `""`               |
| `istio.paperbackWriter.serviceAccountName` | Name of the Paperback Writer service account                                                                                                                      | `paperback-writer` |

## License

Copyright &copy; 2025 Telicent Limited