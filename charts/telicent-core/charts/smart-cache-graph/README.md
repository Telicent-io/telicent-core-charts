# Telicent Package for Smart Cache Graph

Telicent Smart Cache Graph enables efficient storage, retrieval, and querying of complex relationships, making it ideal for applications that require rapid access to interconnected datasets.

## Introduction

This chart bootstraps Telicent Smart Cache Graph deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/smart-cache-graph
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
 --values=charts/telicent-core/charts/smart-cache-graph/values.yaml \
 --readme=charts/telicent-core/charts/smart-cache-graph/README.md \
 --schema=charts/telicent-core/charts/smart-cache-graph/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                                  | Description                                                                                       | Value                    |
| ------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------ |
| `global.imageRegistry`                | Global image registry                                                                             | `""`                     |
| `global.imagePullSecrets`             | Global registry secret names as an array                                                          | `[]`                     |
| `global.appHostDomain`                | Domain name associated with the application                                                       | `apps.telicent.io`       |
| `global.authHostDomain`               | Domain to be used for interacting with Telicent authentication services, including OIDC providers | `auth.telicent.io`       |
| `global.istioServiceAccountName`      | The name of the Istio service account to use for the Smart Cache Graph                            | `istio-ingress`          |
| `global.istioNamespace`               | The namespace where Istio is installed                                                            | `istio-system`           |
| `global.existingTruststoreSecretName` | The name of an existing secret containing the truststore                                          | `""`                     |
| `global.truststore.mountPath`         | The mount path for the truststore in the container                                                | `/app/config/truststore` |

### Configuration Parameters

Contains configuration parameters specific to the Smart Cache Graph application

| Name                                  | Description                         | Value                                                                                  |
| ------------------------------------- | ----------------------------------- | -------------------------------------------------------------------------------------- |
| `configuration.userAttributesUrl`     | URL for the user details endpoint   | `http://access-api.tc-system.svc.cluster.local:8080/users/lookup/{user}`               |
| `configuration.attributeHierarchyUrl` | URL for the user hierarchy endpoint | `http://access-api.tc-system.svc.cluster.local:8080/hierarchies/lookup/{name}`         |
| `configuration.javaOptions`           | JVM options for the application     | `-Xmx5120m -Xms2048m -Djavax.net.ssl.trustStore=/app/config/truststore/truststore.jks` |
| `configuration.otelMetricsExporter`   | OpenTelemetry metrics exporter      | `prometheus`                                                                           |
| `configuration.otelTracesExporter`    | OpenTelemetry traces exporter       | `none`                                                                                 |

### Common Parameters

| Name               | Description                                                                                    | Value |
| ------------------ | ---------------------------------------------------------------------------------------------- | ----- |
| `fullnameOverride` | String to fully override the generated release name                                            | `""`  |
| `nameOverride`     | sets a custom name for the chart it differs from fullnameOverride as it is not fully qualified | `""`  |

### Smart Cache Graph Statefulset Parameters

| Name                                                | Description                                                                      | Value                               |
| --------------------------------------------------- | -------------------------------------------------------------------------------- | ----------------------------------- |
| `replicas`                                          | Number of Smart Cache Graph replicas to deploy                                   | `1`                                 |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                           | `5`                                 |
| `annotations`                                       | Add extra annotations to the Statefulset object                                  | `{}`                                |
| `image.registry`                                    | Smart Cache Graph image registry                                                 | `REGISTRY_NAME`                     |
| `image.repository`                                  | Smart Cache Graph image name                                                     | `REPOSITORY_NAME/smart-cache-graph` |
| `image.tag`                                         | Smart Cache Graph image tag. If not set, a tag is generated using the appVersion | `""`                                |
| `image.pullPolicy`                                  | Smart Cache Graph image pull policy                                              | `IfNotPresent`                      |
| `image.pullSecrets`                                 | Specify registry secret names as an array                                        | `[]`                                |
| `resources.requests.cpu`                            | Set containers' CPU request                                                      | `500m`                              |
| `resources.requests.memory`                         | Set containers' memory request                                                   | `8000Mi`                            |
| `resources.limits.cpu`                              | Set containers' CPU limit                                                        | `1500m`                             |
| `resources.limits.memory`                           | Set containers' memory limit                                                     | `12000Mi`                           |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                               | `185`                               |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                             | `185`                               |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                                    | `true`                              |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                        | `false`                             |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                               | `["ALL"]`                           |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                                 | `RuntimeDefault`                    |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID                    | `185`                               |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID                  | `185`                               |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                         | `true`                              |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem          | `185`                               |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile                      | `RuntimeDefault`                    |

### Persistent Volume Claim Parameters

| Name                                                 | Description                                  | Value     |
| ---------------------------------------------------- | -------------------------------------------- | --------- |
| `persistentVolumeClaims.backupsVolume.size`          | PVC Storage Request for Backup volume        | `100Gi`   |
| `persistentVolumeClaims.backupsVolume.storageClass`  | PVC Storage Class for the Backup data volume | `gp3-enc` |
| `persistentVolumeClaims.datasetsVolume.size`         | PVC Storage Request for Graph volume         | `25Gi`    |
| `persistentVolumeClaims.datasetsVolume.storageClass` | iPVC Storage Class for the Graph data volume | `gp3-enc` |

### Metrics Parameters

| Name                   | Description                            | Value     |
| ---------------------- | -------------------------------------- | --------- |
| `metrics.service.port` | is the port for the Prometheus service | `9464`    |
| `metrics.service.name` | is the name for the Prometheus service | `metrics` |

### Traffic Exposure Parameters

| Name                | Description                                                                                                 | Value       |
| ------------------- | ----------------------------------------------------------------------------------------------------------- | ----------- |
| `service.port`      | is the port the service will listen on                                                                      | `3030`      |
| `service.type`      | defines the service type                                                                                    | `ClusterIP` |
| `ingress.principal` | Principal to use for ingress traffic. If not set, defaults to the Istio service account in the istio-system | `""`        |

### Service Account Parameters

| Name                         | Description                                                                                     | Value |
| ---------------------------- | ----------------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.name`        | Name of the created ServiceAccount. If not set, a name is generated using the fullname template | `""`  |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                            | `{}`  |

## License

Copyright &copy; 2025 Telicent Limited