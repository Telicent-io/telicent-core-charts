# Telicent Package for Search

**Search** provides search capabilities and exposes endpoints for querying indexed data.

## Introduction

This chart bootstraps Search deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/search
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
 --values=charts/telicent-core/charts/search/values.yaml \
 --readme=charts/telicent-core/charts/search/README.md \
 --schema=charts/telicent-core/charts/search/values.schema.json
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

### Search Parameters


### Configuration Parameters - Search

Contains configuration parameters specific to the Smart Cach Search application

| Name                                    | Description                         | Value                                                                                        |
| --------------------------------------- | ----------------------------------- | -------------------------------------------------------------------------------------------- |
| `configuration.userAttributesUrl`       | URL for the user details endpoint   | `http://access.tc-system.svc.cluster.local:8080/users/lookup/{user}`                         |
| `configuration.attributeHierarchyUrl`   | URL for the user hierarchy endpoint | `http://access.tc-system.svc.cluster.local:8080/hierarchies/lookup/{name}`                   |
| `configuration.javaOptions`             | JVM options for the application     | `-XX:MaxRAMPercentage=70.0 -Djavax.net.ssl.trustStore=/app/config/truststore/truststore.jks` |
| `configuration.otelMetricsExporter`     | OpenTelemetry metrics exporter      | `prometheus`                                                                                 |
| `configuration.otelTracesExporter`      | OpenTelemetry traces exporter       | `none`                                                                                       |
| `configuration.elasticHost`             | OpenSearch host                     | `https://your.opensearch.host.here:443`                                                      |
| `configuration.elasticPort`             | OpenSearch port number              | `443`                                                                                        |
| `configuration.elasticClusterPort`      | OpenSearch cluster port             | `9200`                                                                                       |
| `configuration.opensearchCompatibility` | Enable OpenSearch compatibility     | `true`                                                                                       |
| `configuration.elasticIndexNames`       | OpenSearch index name(s)            | `search,doc-content`                                                                         |
| `configuration.searchFieldOptions`      | Field options for search            | `primaryName^2,*`                                                                            |

### OpenSearch secrets - Search

| Name                                           | Description                            | Value |
| ---------------------------------------------- | -------------------------------------- | ----- |
| `elasticSecrets.elasticUser`                   | OpenSearch username                    | `""`  |
| `elasticSecrets.elasticPassword`               | OpenSearch user password               | `""`  |
| `elasticSecrets.truststorePass`                | Password for the truststore            | `""`  |
| `elasticSecrets.existingEnvironmentSecretName` | Name of an existing environment secret | `""`  |

### Common Parameters - Search

| Name               | Description                                                            | Value |
| ------------------ | ---------------------------------------------------------------------- | ----- |
| `fullnameOverride` | String to fully override the generated release name                    | `""`  |
| `nameOverride`     | String to partially override fullname (will maintain the release name) | `""`  |

### Deployment Parameters - Search

| Name                                                | Description                                                             | Value                               |
| --------------------------------------------------- | ----------------------------------------------------------------------- | ----------------------------------- |
| `replicas`                                          | Number of Search replicas to deploy                                     | `1`                                 |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                  | `5`                                 |
| `annotations`                                       | Add extra annotations to the Deployment object                          | `{}`                                |
| `extraEnvs`                                         | List of additional environment variables to set in the pod              | `[]`                                |
| `image.registry`                                    | Search image registry                                                   | `REGISTRY_NAME`                     |
| `image.repository`                                  | Search image name                                                       | `REPOSITORY_NAME/search-api-server` |
| `image.tag`                                         | Search image tag. If not set, a tag is generated using the appVersion   | `""`                                |
| `image.pullPolicy`                                  | Search image pull policy                                                | `IfNotPresent`                      |
| `image.pullSecrets`                                 | Specify registry secret names as an array                               | `[]`                                |
| `resources.requests.cpu`                            | Set containers' CPU request                                             | `500m`                              |
| `resources.requests.memory`                         | Set containers' memory request                                          | `4000Mi`                            |
| `resources.limits.cpu`                              | Set containers' CPU limit                                               | `1000m`                             |
| `resources.limits.memory`                           | Set containers' memory limit                                            | `8000Mi`                            |
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

### Metrics Parameters - Search

| Name                   | Description                     | Value     |
| ---------------------- | ------------------------------- | --------- |
| `metrics.service.name` | Name for the Prometheus service | `metrics` |
| `metrics.service.port` | Port for the Prometheus service | `9464`    |

### Traffic Exposure Parameters - Search

| Name                             | Description                                                                                                                                                                  | Value       |
| -------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| `service.port`                   | Search service port                                                                                                                                                          | `8181`      |
| `service.type`                   | Search service port                                                                                                                                                          | `ClusterIP` |
| `istio.ingress.principal`        | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using 'global.istioNamespace' and 'global.istioServiceAccountName' | `""`        |
| `istio.graph.principal`          | Principal used for Graph traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using 'serviceAccountName' and the current namespace                 | `""`        |
| `istio.graph.serviceAccountName` | Name of the Graph service account                                                                                                                                            | `graph`     |

### Service Account Parameters - Search

| Name                         | Description                                                                                     | Value |
| ---------------------------- | ----------------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.name`        | Name of the created ServiceAccount. If not set, a name is generated using the fullname template | `""`  |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                            | `{}`  |

## License

Copyright &copy; 2025 Telicent Limited