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

| Name                                   | Description                                                                       | Value                                            |
| -------------------------------------- | --------------------------------------------------------------------------------- | ------------------------------------------------ |
| `global.imageRegistry`                 | Global image registry                                                             | `""`                                             |
| `global.imagePullSecrets`              | Global registry secret names as an array                                          | `[]`                                             |
| `global.enterprise`                    | Enable enterprise mode, adding additional features and configurations             | `false`                                          |
| `global.appHostDomain`                 | Domain associated with Telicent application services                              | `apps.telicent.io`                               |
| `global.authHostDomain`                | Domain associated with Telicent authentication services, including OIDC providers | `auth.telicent.io`                               |
| `global.jwksUrl`                       | Endpoint exposing multiple public keys represented as JWKs (JSON Web Key Set)     | `https://{yourAuthdomain}/.well-known/jwks.json` |
| `global.istioNamespace`                | Namespace in which Istio is deployed                                              | `istio-system`                                   |
| `global.istioServiceAccountName`       | Name of the Istio service account                                                 | `istio-ingress`                                  |
| `global.istioGatewayName`              | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)         | `ingress-gateway`                                |
| `global.kafkaBootstrapUrls`            | Comma separated list containing Kafka bootstrap URLs                              | `kafka-bootstrap.kafka.svc.cluster.local:9092`   |
| `global.existingKafkaConfigSecretName` | Name of an existing secret containing Kafka configuration                         | `""`                                             |
| `global.existingTruststoreSecretName`  | Name of an existing secret containing the truststore                              | `""`                                             |
| `global.truststore.mountPath`          | The mount path for the truststore in the container                                | `/app/config/truststore`                         |

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

| Name               | Description                                                            | Value |
| ------------------ | ---------------------------------------------------------------------- | ----- |
| `fullnameOverride` | String to fully override the generated release name                    | `""`  |
| `nameOverride`     | String to partially override fullname (will maintain the release name) | `""`  |

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

| Name                                                 | Description                                  | Value  |
| ---------------------------------------------------- | -------------------------------------------- | ------ |
| `persistentVolumeClaims.backupsVolume.size`          | PVC Storage Request for the Backup volume    | `25Gi` |
| `persistentVolumeClaims.backupsVolume.storageClass`  | PVC Storage Class for the Backup data volume | `gp3`  |
| `persistentVolumeClaims.datasetsVolume.size`         | PVC Storage Request for the Graph volume     | `25Gi` |
| `persistentVolumeClaims.datasetsVolume.storageClass` | iPVC Storage Class for the Graph data volume | `gp3`  |

### Metrics Parameters

| Name                   | Description                     | Value     |
| ---------------------- | ------------------------------- | --------- |
| `metrics.service.name` | Name for the Prometheus service | `metrics` |
| `metrics.service.port` | Port for the Prometheus service | `9464`    |

### Traffic Exposure Parameters

| Name                      | Description                                                                                                                                                                  | Value       |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| `service.port`            | Smart Cache Graph service port                                                                                                                                               | `3030`      |
| `service.type`            | Smart Cache Graph service type                                                                                                                                               | `ClusterIP` |
| `istio.ingress.principal` | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using 'global.istioNamespace' and 'global.istioServiceAccountName' | `""`        |

### Service Account Parameters

| Name                         | Description                                                                           | Value |
| ---------------------------- | ------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`  |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`  |

## License

Copyright &copy; 2025 Telicent Limited