# Telicent Package for Smart Cache Search

Telicent Smart Cache Search allows for testing and demonstrating of Attribute-Based Access Control (ABAC) capabilities within
Telicent CORE.

## Introduction

This chart bootstraps Telicent Smart Cache Search deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/access-ui
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
 --values=charts/telicent-core/charts/access-ui/values.yaml \
 --readme=charts/telicent-core/charts/access-ui/README.md \
 --schema=charts/telicent-core/charts/access-ui/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                             | Description                                                                                       | Value              |
| -------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------ |
| `global.imageRegistry`           | Global image registry                                                                             | `""`               |
| `global.imagePullSecrets`        | Global registry secret names as an array                                                          | `[]`               |
| `global.appHostDomain`           | Domain name associated with Access UI                                                             | `apps.telicent.io` |
| `global.authHostDomain`          | Domain to be used for interacting with Telicent authentication services, including OIDC providers | `auth.telicent.io` |
| `global.istioServiceAccountName` | The name of the Istio service account to use for the Access API                                   | `istio-ingress`    |
| `global.istioNamespace`          | The namespace where Istio is installed                                                            | `istio-system`     |

### api configuration This section contains configuration options specific to the Telicent Search API.

| Name                       | Description                                       | Value |
| -------------------------- | ------------------------------------------------- | ----- |
| `api.annotations`          | are additional annotations to add to the pod      | `{}`  |
| `api.replicas`             | sets the number of replicas for the Search API    | `1`   |
| `api.resources`            | sets the resource requests and limits for the pod | `{}`  |
| `api.revisionHistoryLimit` | sets the number of old ReplicaSets to retain      | `3`   |

### image configuration

| Name                         | Description                                       | Value                                                            |
| ---------------------------- | ------------------------------------------------- | ---------------------------------------------------------------- |
| `api.image.imagePullSecrets` | is a list of secrets to use for pulling the image | `[]`                                                             |
| `api.image.pullPolicy`       | defines the image pull policy                     | `IfNotPresent`                                                   |
| `api.image.repository`       | is the Docker repository for the image            | `098669589541.dkr.ecr.eu-west-2.amazonaws.com/search-api-server` |
| `api.image.tag`              | is the image tag to use                           | `""`                                                             |

### containerSecurityContext sets the container security context

| Name                                                    | Description                                          | Value            |
| ------------------------------------------------------- | ---------------------------------------------------- | ---------------- |
| `api.containerSecurityContext.allowPrivilegeEscalation` | prevents privilege escalation                        | `false`          |
| `api.containerSecurityContext.capabilities.drop`        | drop all capabilities                                | `["ALL"]`        |
| `api.containerSecurityContext.runAsGroup`               | sets the group ID for the container                  | `185`            |
| `api.containerSecurityContext.runAsNonRoot`             | ensures the container runs as a non-root user        | `true`           |
| `api.containerSecurityContext.runAsUser`                | sets the user ID for the container                   | `185`            |
| `api.containerSecurityContext.seccompProfile.type`      | defines the seccomp profile type                     | `RuntimeDefault` |
| `api.podSecurityContext.fsGroup`                        | fsGroup sets the filesystem group ID for the pod     | `185`            |
| `api.podSecurityContext.runAsGroup`                     | runAsGroup sets the group ID for the pod             | `185`            |
| `api.podSecurityContext.runAsNonRoot`                   | runAsNonRoot ensures the pod runs as a non-root user | `true`           |
| `api.podSecurityContext.runAsUser`                      | runAsUser sets the user ID for the pod               | `185`            |
| `api.podSecurityContext.seccompProfile.type`            | defines the seccomp profile type                     | `RuntimeDefault` |

### metrics configuration

| Name                       | Description                                                     | Value  |
| -------------------------- | --------------------------------------------------------------- | ------ |
| `api.metrics.service.port` | is the port for the Prometheus service                          | `9464` |
| `api.extraEnvs`            | is a list of additional environment variables to set in the pod | `[]`   |

### API Configuration Parameters

Contains configuration parameters specific to the Access UI application

| Name                                        | Description                                                | Value                                                                          |
| ------------------------------------------- | ---------------------------------------------------------- | ------------------------------------------------------------------------------ |
| `api.configuration.attributeHierarchyUrl`   | is the URL for the attribute hierarchy endpoint            | `http://access-api.tc-system.svc.cluster.local:8080/hierarchies/lookup/{name}` |
| `api.configuration.elasticHost`             | is the host for the OpenSearch instance                    | `https://your.opensearch.host.here:443`                                        |
| `api.configuration.elasticIndexNames`       | is the name of the index in OpenSearch                     | `search,doc-content`                                                           |
| `api.configuration.elasticPort`             | is the port for the OpenSearch instance                    | `443`                                                                          |
| `api.configuration.elasticClusterPort`      | is the port for the OpenSearch cluster                     | `9200`                                                                         |
| `api.configuration.searchFieldOptions`      | is the field options for search                            | `primaryName^2,*`                                                              |
| `api.configuration.javaOptions`             | are the JVM options for the application                    | `-XX:MaxRAMPercentage=70.0`                                                    |
| `api.configuration.opensearchCompatibility` | indicates if the application is compatible with OpenSearch | `true`                                                                         |
| `api.configuration.otelMetricsExporter`     | is the OpenTelemetry metrics exporter                      | `prometheus`                                                                   |
| `api.configuration.otelTracesExporter`      | is the OpenTelemetry traces exporter                       | `none`                                                                         |
| `api.configuration.userAttributesUrl`       | is the URL for the user attributes endpoint                | `http://access-api.tc-system.svc.cluster.local:8080/users/lookup/{user}`       |

### service configuration

| Name                                               | Description                                   | Value       |
| -------------------------------------------------- | --------------------------------------------- | ----------- |
| `api.service.port`                                 | is the port the service will listen on        | `8181`      |
| `api.service.type`                                 | is the type of service to create              | `ClusterIP` |
| `api.elasticSecrets.elasticPassword`               | is the password for the OpenSearch user       | `""`        |
| `api.elasticSecrets.elasticUser`                   | is the username for the OpenSearch user       | `""`        |
| `api.elasticSecrets.truststorePass`                | is the password for the truststore            | `""`        |
| `api.elasticSecrets.existingEnvironmentSecretName` | is the name of an existing environment secret | `""`        |

### projector configuration

This section contains configuration options for the Smart Cache Search Projector.
The projector is responsible for indexing data into the search engine. // TODO check wording

| Name                             | Description                                       | Value |
| -------------------------------- | ------------------------------------------------- | ----- |
| `projector.annotations`          | are additional annotations to add to the pod      | `{}`  |
| `projector.replicas`             | sets the number of replicas for the Search API    | `1`   |
| `projector.resources`            | sets the resource requests and limits for the pod | `{}`  |
| `projector.revisionHistoryLimit` | sets the number of old ReplicaSets to retain      | `3`   |

### projector.image is the image configuration

appVersion is used by default when defining an empty string

| Name                               | Description                                       | Value                                                                    |
| ---------------------------------- | ------------------------------------------------- | ------------------------------------------------------------------------ |
| `projector.image.imagePullSecrets` | is a list of secrets to use for pulling the image | `[]`                                                                     |
| `projector.image.pullPolicy`       | defines the image pull policy                     | `IfNotPresent`                                                           |
| `projector.image.repository`       | is the Docker repository for the image            | `098669589541.dkr.ecr.eu-west-2.amazonaws.com/smart-cache-elastic-index` |
| `projector.image.tag`              | is the image tag to use                           | `""`                                                                     |

### projector.containerSecurityContext sets the container security context

| Name                                                          | Description                   | Value   |
| ------------------------------------------------------------- | ----------------------------- | ------- |
| `projector.containerSecurityContext.allowPrivilegeEscalation` | prevents privilege escalation | `false` |

### projector.containerSecurityContext.capabilities sets the capabilities for the container

| Name                                                     | Description                                                                              | Value            |
| -------------------------------------------------------- | ---------------------------------------------------------------------------------------- | ---------------- |
| `projector.containerSecurityContext.capabilities.drop`   | all capabilities                                                                         | `["ALL"]`        |
| `projector.containerSecurityContext.runAsGroup`          | sets the group ID for the container                                                      | `185`            |
| `projector.containerSecurityContext.runAsNonRoot`        | ensures the container runs as a non-root user                                            | `true`           |
| `projector.containerSecurityContext.runAsUser`           | sets the user ID for the container                                                       | `185`            |
| `projector.containerSecurityContext.seccompProfile.type` | defines the seccomp profile type RuntimeDefault uses the default runtime seccomp profile | `RuntimeDefault` |
| `projector.podSecurityContext.fsGroup`                   | sets the filesystem group ID for the pod                                                 | `185`            |
| `projector.podSecurityContext.runAsGroup`                | sets the group ID for the pod                                                            | `185`            |
| `projector.podSecurityContext.runAsNonRoot`              | ensures the pod runs as a non-root user                                                  | `true`           |
| `projector.podSecurityContext.runAsUser`                 | sets the user ID for the pod                                                             | `185`            |
| `projector.podSecurityContext.seccompProfile.type`       | defines the seccomp profile type RuntimeDefault uses the default runtime seccomp profile | `RuntimeDefault` |
| `projector.metrics.service.port`                         | is the port for the Prometheus service                                                   | `9464`           |
| `projector.extraEnvs`                                    | is a list of additional environment variables to set in the pod                          | `[]`             |
| `projector.elasticSecrets.elasticPassword`               | is the password for the OpenSearch user                                                  | `""`             |
| `projector.elasticSecrets.elasticUser`                   | is the username for the OpenSearch user                                                  | `""`             |
| `projector.elasticSecrets.truststorePass`                | is the password for the truststore                                                       | `""`             |
| `projector.elasticSecrets.existingEnvironmentSecretName` | is a section for an existing environment secret                                          | `""`             |

### projector.configuration is for projector specific settings

| Name                                              | Description                                                | Value                                   |
| ------------------------------------------------- | ---------------------------------------------------------- | --------------------------------------- |
| `projector.configuration.topic`                   | is the topic to consume from the message broker            | `knowledge`                             |
| `projector.configuration.dlqTopic`                | is the dead-letter queue topic for failed messages         | `knowledge.dlq`                         |
| `projector.configuration.elasticHost`             | is the host for the OpenSearch instance                    | `https://your.opensearch.host.here:443` |
| `projector.configuration.elasticIndex`            | is the name of the index in OpenSearch                     | `search`                                |
| `projector.configuration.elasticPort`             | is the port for the OpenSearch instance                    | `443`                                   |
| `projector.configuration.javaOptions`             | are the Java options to use for the OpenSearch instance    | `-XX:MaxRAMPercentage=70.0`             |
| `projector.configuration.indexBatchSize`          | is the batch size for indexing documents                   | `500`                                   |
| `projector.configuration.opensearchCompatibility` | indicates if the application is compatible with OpenSearch | `true`                                  |
| `projector.configuration.otelMetricsExporter`     | is the OpenTelemetry metrics exporter                      | `prometheus`                            |
| `projector.configuration.otelTracesExporter`      | is the OpenTelemetry traces exporter                       | `none`                                  |

### serviceAccount configuration

| Name                         | Description                                                                                    | Value |
| ---------------------------- | ---------------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.annotations` | are additional annotations for the service account                                             | `{}`  |
| `serviceAccount.name`        | is the name of the service account                                                             | `""`  |
| `fullnameOverride`           | sets the full name of the chart                                                                | `""`  |
| `nameOverride`               | sets a custom name for the chart it differs from fullnameOverride as it is not fully qualified | `""`  |

### ingress configuration

| Name                    | Description                                      | Value |
| ----------------------- | ------------------------------------------------ | ----- |
| `ingress.principal`     | is the principal to use for ingress traffic      | `""`  |
| `graphServer.principal` | is the principal to use for graph server traffic | `""`  |
