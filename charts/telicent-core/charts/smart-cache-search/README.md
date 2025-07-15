# Telicent Package for Smart Cache Search

Telicent Smart Cache Search is a two-part system consisting of:

- **API**: Provides search capabilities and exposes endpoints for querying indexed data.
- **Projector**: Responsible for ingesting and indexing data into the search engine, ensuring that the API has up-to-date information to serve queries.

Both components are deployed as part of this Helm chart and can be configured independently to suit your deployment needs.

## Introduction

This chart bootstraps Telicent Smart Cache Search deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/smart-cache-search
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
 --values=charts/telicent-core/charts/smart-cache-search/values.yaml \
 --readme=charts/telicent-core/charts/smart-cache-search/README.md \
 --schema=charts/telicent-core/charts/smart-cache-search/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                                  | Description                                                                                       | Value                    |
| ------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------ |
| `global.imageRegistry`                | Global image registry                                                                             | `""`                     |
| `global.imagePullSecrets`             | Global registry secret names as an array                                                          | `[]`                     |
| `global.appHostDomain`                | Domain name associated with Smart Cache Search API & Projector                                    | `apps.telicent.io`       |
| `global.authHostDomain`               | Domain to be used for interacting with Telicent authentication services, including OIDC providers | `auth.telicent.io`       |
| `global.istioServiceAccountName`      | The name of the Istio service account to use for Smart Cache Search API & Projector               | `istio-ingress`          |
| `global.istioNamespace`               | The namespace where Istio is installed                                                            | `istio-system`           |
| `global.existingTruststoreSecretName` | The name of an existing secret containing the truststore                                          | `""`                     |
| `global.truststore.mountPath`         | The mount path for the truststore in the container                                                | `/app/config/truststore` |

### Smart Cache Search API Parameters


### Configuration Parameters - Smart Cache Search API

Contains configuration parameters specific to the Smart Cache Search API application

| Name                                        | Description                         | Value                                                                          |
| ------------------------------------------- | ----------------------------------- | ------------------------------------------------------------------------------ |
| `api.configuration.userAttributesUrl`       | URL for the user details endpoint   | `http://access-api.tc-system.svc.cluster.local:8080/users/lookup/{user}`       |
| `api.configuration.attributeHierarchyUrl`   | URL for the user hierarchy endpoint | `http://access-api.tc-system.svc.cluster.local:8080/hierarchies/lookup/{name}` |
| `api.configuration.javaOptions`             | JVM options for the application     | `-XX:MaxRAMPercentage=70.0`                                                    |
| `api.configuration.otelMetricsExporter`     | OpenTelemetry metrics exporter      | `prometheus`                                                                   |
| `api.configuration.otelTracesExporter`      | OpenTelemetry traces exporter       | `none`                                                                         |
| `api.configuration.elasticHost`             | OpenSearch host                     | `https://your.opensearch.host.here:443`                                        |
| `api.configuration.elasticPort`             | OpenSearch port number              | `443`                                                                          |
| `api.configuration.elasticClusterPort`      | OpenSearch cluster port             | `9200`                                                                         |
| `api.configuration.opensearchCompatibility` | Enable OpenSearch compatibility     | `true`                                                                         |
| `api.configuration.elasticIndexNames`       | OpenSearch index name(s)            | `search,doc-content`                                                           |
| `api.configuration.searchFieldOptions`      | Field options for search            | `primaryName^2,*`                                                              |

### OpenSearch secrets - Smart Cache Search API

| Name                                               | Description                            | Value |
| -------------------------------------------------- | -------------------------------------- | ----- |
| `api.elasticSecrets.elasticUser`                   | OpenSearch username                    | `""`  |
| `api.elasticSecrets.elasticPassword`               | OpenSearch user password               | `""`  |
| `api.elasticSecrets.truststorePass`                | Password for the truststore            | `""`  |
| `api.elasticSecrets.existingEnvironmentSecretName` | Name of an existing environment secret | `""`  |

### Common Parameters - Smart Cache Search API

| Name                   | Description                                                            | Value |
| ---------------------- | ---------------------------------------------------------------------- | ----- |
| `api.fullnameOverride` | String to fully override the generated release name                    | `""`  |
| `api.nameOverride`     | String to partially override fullname (will maintain the release name) | `""`  |

### Deployment Parameters - Smart Cache Search API

| Name                                                    | Description                                                                           | Value                               |
| ------------------------------------------------------- | ------------------------------------------------------------------------------------- | ----------------------------------- |
| `api.replicas`                                          | Number of Smart Cache Search API replicas to deploy                                   | `1`                                 |
| `api.revisionHistoryLimit`                              | Number of controller revisions to keep                                                | `5`                                 |
| `api.annotations`                                       | Add extra annotations to the Deployment object                                        | `{}`                                |
| `api.extraEnvs`                                         | List of additional environment variables to set in the pod                            | `[]`                                |
| `api.image.registry`                                    | Smart Cache Search API image registry                                                 | `REGISTRY_NAME`                     |
| `api.image.repository`                                  | Smart Cache Search API image name                                                     | `REPOSITORY_NAME/search-api-server` |
| `api.image.tag`                                         | Smart Cache Search API image tag. If not set, a tag is generated using the appVersion | `""`                                |
| `api.image.pullPolicy`                                  | Smart Cache Search API image pull policy                                              | `IfNotPresent`                      |
| `api.image.pullSecrets`                                 | Specify registry secret names as an array                                             | `[]`                                |
| `api.resources.requests.cpu`                            | Set containers' CPU request                                                           | `500m`                              |
| `api.resources.requests.memory`                         | Set containers' memory request                                                        | `4000Mi`                            |
| `api.resources.limits.cpu`                              | Set containers' CPU limit                                                             | `1000m`                             |
| `api.resources.limits.memory`                           | Set containers' memory limit                                                          | `8000Mi`                            |
| `api.containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                                    | `185`                               |
| `api.containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                                  | `185`                               |
| `api.containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                                         | `true`                              |
| `api.containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                             | `false`                             |
| `api.containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                                    | `["ALL"]`                           |
| `api.containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                                      | `RuntimeDefault`                    |
| `api.podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID                         | `185`                               |
| `api.podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID                       | `185`                               |
| `api.podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                              | `true`                              |
| `api.podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem               | `185`                               |
| `api.podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile                           | `RuntimeDefault`                    |

### Metrics Parameters - Smart Cache Search API

| Name                       | Description                     | Value     |
| -------------------------- | ------------------------------- | --------- |
| `api.metrics.service.name` | Name for the Prometheus service | `metrics` |
| `api.metrics.service.port` | Port for the Prometheus service | `9464`    |

### Traffic Exposure Parameters - Smart Cache Search API

| Name                    | Description                                                                                                 | Value       |
| ----------------------- | ----------------------------------------------------------------------------------------------------------- | ----------- |
| `api.service.port`      | Smart Cache Search API service port                                                                         | `8181`      |
| `api.service.type`      | Smart Cache Search API service port                                                                         | `ClusterIP` |
| `api.ingress.principal` | Principal to use for ingress traffic. If not set, defaults to the Istio service account in the istio-system | `""`        |

### Service Account Parameters - Smart Cache Search Api

| Name                             | Description                                                                                     | Value |
| -------------------------------- | ----------------------------------------------------------------------------------------------- | ----- |
| `api.serviceAccount.name`        | Name of the created ServiceAccount. If not set, a name is generated using the fullname template | `""`  |
| `api.serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                            | `{}`  |

### Smart Cache Search Projector/Indexer Parameters


### Configuration Parameters - Smart Cache Search Projector

Contains configuration parameters specific to the Smart Cache Search Projector application

| Name                                              | Description                           | Value                                                                                        |
| ------------------------------------------------- | ------------------------------------- | -------------------------------------------------------------------------------------------- |
| `projector.configuration.javaOptions`             | JVM options for the application       | `-XX:MaxRAMPercentage=70.0 -Djavax.net.ssl.trustStore=/app/config/truststore/truststore.jks` |
| `projector.configuration.otelMetricsExporter`     | OpenTelemetry metrics exporter        | `prometheus`                                                                                 |
| `projector.configuration.otelTracesExporter`      | OpenTelemetry traces exporter         | `none`                                                                                       |
| `projector.configuration.elasticHost`             | OpenSearch host                       | `https://your.opensearch.host.here:443`                                                      |
| `projector.configuration.elasticPort`             | OpenSearch port number                | `443`                                                                                        |
| `projector.configuration.elasticClusterPort`      | OpenSearch cluster port               | `9200`                                                                                       |
| `projector.configuration.opensearchCompatibility` | Enable OpenSearch compatibility       | `true`                                                                                       |
| `projector.configuration.elasticIndex`            | Name of the index in OpenSearch       | `search`                                                                                     |
| `projector.configuration.topic`                   | Topic to consume messages from        | `knowledge`                                                                                  |
| `projector.configuration.dlqTopic`                | Dead-letter topic for failed messages | `knowledge.dlq`                                                                              |
| `projector.configuration.indexBatchSize`          | Batch size for indexing documents     | `500`                                                                                        |

### OpenSearch secrets - Smart Cache Search Projector

| Name                                                     | Description                            | Value |
| -------------------------------------------------------- | -------------------------------------- | ----- |
| `projector.elasticSecrets.elasticUser`                   | OpenSearch username                    | `""`  |
| `projector.elasticSecrets.elasticPassword`               | OpenSearch user password               | `""`  |
| `projector.elasticSecrets.truststorePass`                | Password for the truststore            | `""`  |
| `projector.elasticSecrets.existingEnvironmentSecretName` | Name of an existing environment secret | `""`  |

### Deployment Parameters - Smart Cache Search Projector

| Name                                                          | Description                                                                                 | Value                               |
| ------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ----------------------------------- |
| `projector.replicas`                                          | Number of Smart Cache Search Projector replicas to deploy                                   | `1`                                 |
| `projector.revisionHistoryLimit`                              | Number of controller revisions to keep                                                      | `5`                                 |
| `projector.annotations`                                       | Add extra annotations to the Deployment object                                              | `{}`                                |
| `projector.extraEnvs`                                         | List of additional environment variables to set in the pod                                  | `[]`                                |
| `projector.image.registry`                                    | Smart Cache Search Projector image registry                                                 | `REGISTRY_NAME`                     |
| `projector.image.repository`                                  | Smart Cache Search Projector image name                                                     | `REPOSITORY_NAME/search-api-server` |
| `projector.image.tag`                                         | Smart Cache Search Projector image tag. If not set, a tag is generated using the appVersion | `""`                                |
| `projector.image.pullPolicy`                                  | Smart Cache Search Projector image pull policy                                              | `IfNotPresent`                      |
| `projector.image.pullSecrets`                                 | Specify registry secret names as an array                                                   | `[]`                                |
| `projector.resources.requests.cpu`                            | Set containers' CPU request                                                                 | `250m`                              |
| `projector.resources.requests.memory`                         | Set containers' memory request                                                              | `1000Mi`                            |
| `projector.resources.limits.cpu`                              | Set containers' CPU limit                                                                   | `500m`                              |
| `projector.resources.limits.memory`                           | Set containers' memory limit                                                                | `2000Mi`                            |
| `projector.containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                                          | `185`                               |
| `projector.containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                                        | `185`                               |
| `projector.containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                                               | `true`                              |
| `projector.containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                                   | `false`                             |
| `projector.containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                                          | `["ALL"]`                           |
| `projector.containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                                            | `RuntimeDefault`                    |
| `projector.podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID                               | `185`                               |
| `projector.podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID                             | `185`                               |
| `projector.podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                                    | `true`                              |
| `projector.podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem                     | `185`                               |
| `projector.podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile                                 | `RuntimeDefault`                    |

### Metrics Parameters - Smart Cache Search Projector

| Name                             | Description                     | Value     |
| -------------------------------- | ------------------------------- | --------- |
| `projector.metrics.service.name` | Name for the Prometheus service | `metrics` |
| `projector.metrics.service.port` | Port for the Prometheus service | `9464`    |

### Traffic Exposure Parameters - Smart Cache Search Projector

| Name                          | Description                                                                                                 | Value       |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------- |
| `projector.service.port`      | Smart Cache Search Projector service port                                                                   | `8181`      |
| `projector.service.type`      | Smart Cache Search Projector service port                                                                   | `ClusterIP` |
| `projector.ingress.principal` | Principal to use for ingress traffic. If not set, defaults to the Istio service account in the istio-system | `""`        |

### Service Account Parameters - Smart Cache Search Projector

| Name                                   | Description                                                                                     | Value |
| -------------------------------------- | ----------------------------------------------------------------------------------------------- | ----- |
| `projector.serviceAccount.name`        | Name of the created ServiceAccount. If not set, a name is generated using the fullname template | `""`  |
| `projector.serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                            | `{}`  |
| `graphServer.principal`                | is the principal to use for graph server traffic                                                | `""`  |

## License

Copyright &copy; 2025 Telicent Limited