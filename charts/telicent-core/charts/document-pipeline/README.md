# Telicent Package for Document Pipeline

Document Pipeline is a document processing pipeline made up of four loosely coupled microservices, each performing a different function but sharing data via Kafka topics.

Native documents, such as Microsoft Word or PDF files, are ingested into the pipeline either via the HTTP Ingester microservice, or via direct submission to Kafka, and then flow through the pipeline, ultimately having their content indexed and searchable within Elasticsearch.

## Introduction

This chart bootstraps Telicent Document Pipeline deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Umbrella chart 

To enable this chart as part of the umbrella chart, please set the key: `.Values.document-pipeline.enabled: true`

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/document-pipeline
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
 --values=charts/telicent-core/charts/document-pipeline/values.yaml \
 --readme=charts/telicent-core/charts/document-pipeline/README.md \
 --schema=charts/telicent-core/charts/document-pipeline/values.schema.json
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

| Name                                    | Description                                                                                                                     | Value                                          |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `global.imageRegistry`                  | Global image registry                                                                                                           | `""`                                           |
| `global.imagePullSecrets`               | Global registry secret names as an array                                                                                        | `[]`                                           |
| `global.appHostDomain`                  | Domain associated with Telicent application/ui services. This value cannot be changed after it is set                           | `""`                                           |
| `global.apiHostDomain`                  | Domain associated with Telicent Api services. This value cannot be changed after it is set                                      | `""`                                           |
| `global.authHostDomain`                 | Domain associated with Telicent authentication services, including OIDC providers. This value cannot be changed after it is set | `""`                                           |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers                                                                         | `kafka-bootstrap.kafka.svc.cluster.local:9092` |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration (preferred over individual settings below for security)               | `""`                                           |
| `global.kafka.username`                 | Username for Kafka authentication                                                                                               | `your.kafka.username.here`                     |
| `global.kafka.password`                 | Password for Kafka authentication                                                                                               | `your.kafka.password.here`                     |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                                                                                           | `SASL_SSL`                                     |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication                                                                                    | `SCRAM-SHA-512`                                |
| `global.truststore.existingSecret`      | Name of an existing secret containing the truststore                                                                            | `""`                                           |
| `global.truststore.mountPath`           | The mount path for the truststore in the container                                                                              | `/app/config/truststore`                       |

### Deployment Resources Parameters - Default resource allocation applied to all sub-chart deployments

| Name        | Description                                  | Value |
| ----------- | -------------------------------------------- | ----- |
| `resources` | Resources for *Document Pipeline* containers | `{}`  |

### Deployment Security Context Parameters - Default security context applied to all sub-chart deployments

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

### Service Account - Shared by sub-chart resources

This section builds out the service account more information can be found here: https://kubernetes.io/docs/concepts/security/service-accounts/

| Name                         | Description                                                                                                            | Value  |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                                                  | `true` |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                                                 | `true` |
| `serviceAccount.annotations` | Annotations to add to the service account                                                                              | `{}`   |
| `serviceAccount.name`        | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | `""`   |

### Host(s) Parameters - Contains host information for applications deployed via *telicent-core* chart

*Document Pipeline* interacts directly with other Telicent Applications using their default service/serviceAccount and port.
If either of those details changes, you can use this section to correctly refer to those applications.

| Name                      | Description                                                                                                                                                                                                                          | Value                |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------- |
| `hosts.enableAutoCorrect` | Allow for the release name to be automatically pre-fixed to each host value when required (default behavior when installing through the parent chart). Alternatively, the host value will be used as it is, without any modification | `true`               |
| `hosts.auth`              | Auth application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                                     | `auth:8080`          |
| `hosts.traefikProxy`      | Traefik Proxy application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                            | `traefik-proxy:8080` |

### *HTTP Ingester*

The *HTTP Ingester* is responsible for ingesting documents via https.
The application settings are defined within the 'java' & 'routes' keys


### *HTTP Ingester* - Application Parameters - Java

| Name                           | Description                     | Value                       |
| ------------------------------ | ------------------------------- | --------------------------- |
| `httpIngester.java.jvmOptions` | Java options to pass to the JVM | `-XX:MaxRAMPercentage=80.0` |

### *HTTP Ingester* - Application Parameters - Routes

| Name                                             | Description                                                                                                                                                                                                                                       | Value                                                                                                              |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `httpIngester.routes[0].name`                    | A unique name for the route                                                                                                                                                                                                                       | `local`                                                                                                            |
| `httpIngester.routes[0].topic`                   | The destination Kafka topic for the route                                                                                                                                                                                                         | `document.extractrequest`                                                                                          |
| `httpIngester.routes[0].securityLabel`           | In this test configuration the label is simply test=true                                                                                                                                                                                          | `dGVzdD10cnVl`                                                                                                     |
| `httpIngester.routes[0].namespace`               | The Namespace URI that will be used to assign a unique URI to a document URIs are generated deterministically based on this and the ingested document content                                                                                     | `https://example.org/ns#`                                                                                          |
| `httpIngester.routes[0].headers[0].name`         | The Owner header, configured such that even if the header is present in the request then the defaultValue here takes precedence                                                                                                                   | `Owner`                                                                                                            |
| `httpIngester.routes[0].headers[0].defaultValue` | The default value for the Owner header                                                                                                                                                                                                            | `Platform Team`                                                                                                    |
| `httpIngester.routes[0].headers[0].priority`     | The priority for the Owner header                                                                                                                                                                                                                 | `CONFIGURATION`                                                                                                    |
| `httpIngester.routes[0].headers[1].name`         | The (deprecated) Data-Source-Name, configured such that if the header is present in the request then the request value takes precedence                                                                                                           | `Data-Source-Name`                                                                                                 |
| `httpIngester.routes[0].headers[1].defaultValue` | The default value for the (deprecated) Data-Source-Name header                                                                                                                                                                                    | `Test Data`                                                                                                        |
| `httpIngester.routes[0].headers[1].priority`     | The priority for the (deprecated) Data-Source-Name header                                                                                                                                                                                         | `REQUEST`                                                                                                          |
| `httpIngester.routes[0].headers[2].name`         | The Distribution ID header. This is necessary to indicate what data catalogue details are associated to the incoming request. NOTE: marked as REQUEST for time being to make development/testing easier but should be REQUEST_ONLY when deployed. | `Data-Source-Reference`                                                                                            |
| `httpIngester.routes[0].headers[2].defaultValue` | The default value for the Distribution ID header                                                                                                                                                                                                  | `Telicent Document Pipeline`                                                                                       |
| `httpIngester.routes[0].headers[2].priority`     | The priority for the Distribution ID header                                                                                                                                                                                                       | `REQUEST`                                                                                                          |
| `httpIngester.routes[0].headers[3].name`         | The Distribution ID header. This is necessary to indicate what data catalogue details are associated to the incoming request. NOTE: marked as REQUEST for time being to make development/testing easier but should be REQUEST_ONLY when deployed. | `Distribution-Id`                                                                                                  |
| `httpIngester.routes[0].headers[3].defaultValue` | The default value for the Distribution ID header                                                                                                                                                                                                  | `13bce3bf-7edb-4efb-a54f-574327458dd7`                                                                             |
| `httpIngester.routes[0].headers[3].priority`     | The priority for the Distribution ID header                                                                                                                                                                                                       | `REQUEST`                                                                                                          |
| `httpIngester.routes[0].headers[4].name`         | The EDH/IDH policy information header                                                                                                                                                                                                             | `Policy-Information`                                                                                               |
| `httpIngester.routes[0].headers[4].defaultValue` | The default value for the EDH/IDH policy information header                                                                                                                                                                                       | `{"EDH":{"classification":"O","permittedNats":["GBR"],"permittedOrgs":["Telicent"],"orGroups":[],"andGroups":[]}}` |
| `httpIngester.routes[0].headers[4].priority`     | The priority for the EDH/IDH policy information header                                                                                                                                                                                            | `REQUEST`                                                                                                          |

### *HTTP Ingester* - Configmap Parameters

| Name                                             | Description                                                                     | Value |
| ------------------------------------------------ | ------------------------------------------------------------------------------- | ----- |
| `httpIngester.configMap.existingEnvConfigMap`    | Name of existing configmap containing *HTTP Ingester* Environment Configuration | `""`  |
| `httpIngester.configMap.existingRoutesConfigMap` | Name of existing configmap containing Routes Configuration                      | `""`  |

### *HTTP Ingester* - Common Parameters

| Name                            | Description                                     | Value |
| ------------------------------- | ----------------------------------------------- | ----- |
| `httpIngester.nameOverride`     | Override the chart name for the *HTTP Ingester* | `""`  |
| `httpIngester.fullnameOverride` | Override the full name for the *HTTP Ingester*  | `""`  |

### *HTTP Ingester* - Deployment Parameters

| Name                             | Description                                                 | Value |
| -------------------------------- | ----------------------------------------------------------- | ----- |
| `httpIngester.replicas`          | Number of replicas to deploy                                | `1`   |
| `httpIngester.annotations`       | Add extra annotations to the deployment object              | `{}`  |
| `httpIngester.podLabels`         | Labels to add to the *HTTP Ingester* pods                   | `{}`  |
| `httpIngester.podAnnotations`    | Annotations to add to the *HTTP Ingester* pods              | `{}`  |
| `httpIngester.extraEnvVars`      | Array with extra environment variables to add               | `[]`  |
| `httpIngester.extraVolumes`      | Additional volumes on the output Deployment definition      | `[]`  |
| `httpIngester.extraVolumeMounts` | Additional volumeMounts on the output Deployment definition | `[]`  |
| `httpIngester.initContainers`    | Add init containers to the pod                              | `[]`  |
| `httpIngester.sidecars`          | Add sidecars to the pod.                                    | `[]`  |

### *HTTP Ingester* - Deployment Image Parameters

| Name                             | Description                                            | Value                                      |
| -------------------------------- | ------------------------------------------------------ | ------------------------------------------ |
| `httpIngester.image.registry`    | *HTTP Ingester* image registry                         | `quay.io`                                  |
| `httpIngester.image.repository`  | The container image repository for the *HTTP Ingester* | `telicent/telicent-document-http-ingester` |
| `httpIngester.image.tag`         | The image tag for the *HTTP Ingester*                  | `3.3.3`                                    |
| `httpIngester.image.pullPolicy`  | The image pull policy for the *HTTP Ingester*          | `IfNotPresent`                             |
| `httpIngester.image.pullSecrets` | Specify registry secret names as an array              | `[]`                                       |

### *HTTP Ingester* - Deployment Resources Parameters - Requests and Limits

| Name                     | Description                              | Value |
| ------------------------ | ---------------------------------------- | ----- |
| `httpIngester.resources` | Resources for *HTTP Ingester* containers | `{}`  |

### *HTTP Ingester* - Deployment Affinity Parameters

| Name                        | Description                    | Value |
| --------------------------- | ------------------------------ | ----- |
| `httpIngester.affinity`     | Affinity for pod assignment    | `{}`  |
| `httpIngester.nodeSelector` | Node labels for pod assignment | `{}`  |
| `httpIngester.tolerations`  | Tolerations for pod assignment | `[]`  |

### *HTTP Ingester* - Deployment Security Context Parameters - Default Security Context

| Name                                    | Description                                                                                                             | Value |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ----- |
| `httpIngester.podSecurityContext`       | Security context for the pod(s). Optional override, otherwise inherited from the root security context definition       | `{}`  |
| `httpIngester.containerSecurityContext` | Security context for the container(s). Optional override, otherwise inherited from the root security context definition | `{}`  |

### *HTTP Ingester* - Traffic Exposure Parameters

| Name                        | Description                                                                      | Value       |
| --------------------------- | -------------------------------------------------------------------------------- | ----------- |
| `httpIngester.service.name` | *HTTP Ingester* service name. If not set, a name is generated using the fullname | `""`        |
| `httpIngester.service.port` | *HTTP Ingester* service port                                                     | `8080`      |
| `httpIngester.service.type` | *HTTP Ingester* service port                                                     | `ClusterIP` |

### *Content Extractor*

The *Content Extractor* is responsible for extracting information from the ingested documents.
The application settings are defined within the 'topics' key


### *Content Extractor* - Application Parameters - Topics

| Name                                  | Description                                                                          | Value                         |
| ------------------------------------- | ------------------------------------------------------------------------------------ | ----------------------------- |
| `contentExtractor.topics.inputTopic`  | The Kafka topic from which the *Content Extractor* will consume messages             | `document.extractrequest`     |
| `contentExtractor.topics.outputTopic` | The Kafka topic to which the *Content Extractor* will produce messages               | `document.textandmetadata`    |
| `contentExtractor.topics.dlqTopic`    | The Kafka topic to which the *Content Extractor* will produce dead-lettered messages | `document.extractrequest.dlq` |

### *Content Extractor* - Common Parameters

| Name                                | Description                                         | Value |
| ----------------------------------- | --------------------------------------------------- | ----- |
| `contentExtractor.nameOverride`     | Override the chart name for the *Content Extractor* | `""`  |
| `contentExtractor.fullnameOverride` | Override the full name for the *Content Extractor*  | `""`  |

### *Content Extractor* - Deployment Parameters

| Name                                        | Description                                                                                                                        | Value                                          |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `contentExtractor.replicas`                 | The number of replicas for the *Content Extractor*                                                                                 | `1`                                            |
| `contentExtractor.annotations`              | Add extra annotations to the deployment object                                                                                     | `{}`                                           |
| `contentExtractor.podLabels`                | Labels to add to the *Content Extractor* pods                                                                                      | `{}`                                           |
| `contentExtractor.podAnnotations`           | Annotations to add to the *Content Extractor* pods                                                                                 | `{}`                                           |
| `contentExtractor.extraEnvVars`             | Array with extra environment variables to add                                                                                      | `[]`                                           |
| `contentExtractor.extraVolumes`             | Additional volumes for the *Content Extractor*                                                                                     | `[]`                                           |
| `contentExtractor.extraVolumeMounts`        | Additional volume mounts for the *Content Extractor*                                                                               | `[]`                                           |
| `contentExtractor.initContainers`           | Add init containers to the pod                                                                                                     | `[]`                                           |
| `contentExtractor.sidecars`                 | Add sidecars to the pod.                                                                                                           | `[]`                                           |
| `contentExtractor.image.registry`           | *Content Extractor* image registry                                                                                                 | `quay.io`                                      |
| `contentExtractor.image.repository`         | The container image repository for the *Content Extractor*                                                                         | `telicent/telicent-document-content-extractor` |
| `contentExtractor.image.tag`                | The image tag for the *Content Extractor*                                                                                          | `3.3.3`                                        |
| `contentExtractor.image.pullPolicy`         | The image pull policy for the *Content Extractor*                                                                                  | `IfNotPresent`                                 |
| `contentExtractor.image.pullSecrets`        | Secrets for pulling an image from a private repository                                                                             | `[]`                                           |
| `contentExtractor.affinity`                 | Affinity rules for the *Content Extractor* pods                                                                                    | `{}`                                           |
| `contentExtractor.nodeSelector`             | Node selector for the *Content Extractor* pods                                                                                     | `{}`                                           |
| `contentExtractor.tolerations`              | Tolerations for the *Content Extractor* pods                                                                                       | `[]`                                           |
| `contentExtractor.resources`                | Resource requests and limits for the *Content Extractor*. Optional override, otherwise inherited from the root resource definition | `{}`                                           |
| `contentExtractor.podSecurityContext`       | Security context for the pod(s). Optional override, otherwise inherited from the root security context definition                  | `{}`                                           |
| `contentExtractor.containerSecurityContext` | Security context for the container(s). Optional override, otherwise inherited from the root security context definition            | `{}`                                           |

### *Content Indexer*

The *Content Indexer* is responsible for indexing documents.
The application settings are defined within the 'java' & 'elastic' keys


### *Content Indexer* - Application Parameters - Java

| Name                             | Description                     | Value                       |
| -------------------------------- | ------------------------------- | --------------------------- |
| `contentIndexer.java.jvmOptions` | JVM options for the application | `-XX:MaxRAMPercentage=80.0` |

### *Content Indexer* Application Parameters - Elastic/OpenSearch and Secret

The following contains connection details to an Elastic/OpenSearch service, on which the application relies.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-usr-elastic-document-pipeline-content-indexer` will be created if one is not set.

| Name                                             | Description                                                                        | Value                                        |
| ------------------------------------------------ | ---------------------------------------------------------------------------------- | -------------------------------------------- |
| `contentIndexer.elastic.host`                    | Elastic/OpenSearch host                                                            | `https://your.opensearch.host`               |
| `contentIndexer.elastic.port`                    | Elastic/OpenSearch port number                                                     | `443`                                        |
| `contentIndexer.elastic.opensearchCompatibility` | Enable OpenSearch compatibility                                                    | `true`                                       |
| `contentIndexer.elastic.index`                   | Elastic/OpenSearch index to be used                                                | `doc-content`                                |
| `contentIndexer.elastic.topic`                   | The Kafka topic from which the content indexer will consume messages               | `document.textandmetadata,document.entities` |
| `contentIndexer.elastic.dlqTopic`                | The Kafka topic to which the content indexer will produce dead-lettered messages   | `document.textandmetadata.dlq`               |
| `contentIndexer.elastic.existingSecret`          | Name of an existing secret. The secret must contain 2 keys: 'username', 'password' | `""`                                         |
| `contentIndexer.elastic.username`                | OpenSearch/Elastic username                                                        | `""`                                         |
| `contentIndexer.elastic.password`                | OpenSearch/Elastic user password                                                   | `""`                                         |

### *Content Indexer* - Common Parameters

| Name                              | Description                                       | Value |
| --------------------------------- | ------------------------------------------------- | ----- |
| `contentIndexer.nameOverride`     | Override the chart name for the *Content Indexer* | `""`  |
| `contentIndexer.fullnameOverride` | Override the full name for the *Content Indexer*  | `""`  |

### *Content Indexer* - Deployment Parameters

| Name                                      | Description                                                                                                                      | Value                                        |
| ----------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| `contentIndexer.replicas`                 | Number of replicas to deploy                                                                                                     | `1`                                          |
| `contentIndexer.annotations`              | Add extra annotations to the deployment object                                                                                   | `{}`                                         |
| `contentIndexer.podLabels`                | Labels to add to the *Content Indexer* pods                                                                                      | `{}`                                         |
| `contentIndexer.podAnnotations`           | Annotations to add to the *Content Indexer* pods                                                                                 | `{}`                                         |
| `contentIndexer.extraEnvVars`             | Array with extra environment variables to add                                                                                    | `[]`                                         |
| `contentIndexer.extraVolumes`             | Additional volumes for the *Content Indexer*                                                                                     | `[]`                                         |
| `contentIndexer.extraVolumeMounts`        | Additional volume mounts for the *Content Indexer*                                                                               | `[]`                                         |
| `contentIndexer.initContainers`           | Add init containers to the pod                                                                                                   | `[]`                                         |
| `contentIndexer.sidecars`                 | Add sidecars to the pod.                                                                                                         | `[]`                                         |
| `contentIndexer.image.registry`           | *Content Indexer* image registry                                                                                                 | `quay.io`                                    |
| `contentIndexer.image.repository`         | The container image repository for the *Content Indexer*                                                                         | `telicent/telicent-document-content-indexer` |
| `contentIndexer.image.pullPolicy`         | The image pull policy for the *Content Indexer*                                                                                  | `IfNotPresent`                               |
| `contentIndexer.image.tag`                | The image tag for the *Content Indexer*                                                                                          | `3.3.3`                                      |
| `contentIndexer.image.pullSecrets`        | Secrets for pulling an image from a private repository                                                                           | `[]`                                         |
| `contentIndexer.affinity`                 | Affinity rules for the *Content Indexer* pods                                                                                    | `{}`                                         |
| `contentIndexer.nodeSelector`             | Node selector for the *Content Indexer* pods                                                                                     | `{}`                                         |
| `contentIndexer.tolerations`              | Tolerations for the *Content Indexer* pods                                                                                       | `[]`                                         |
| `contentIndexer.resources`                | Resource requests and limits for the *Content Indexer*. Optional override, otherwise inherited from the root resource definition | `{}`                                         |
| `contentIndexer.podSecurityContext`       | Security context for the pod(s). Optional override, otherwise inherited from the root security context definition                | `{}`                                         |
| `contentIndexer.containerSecurityContext` | Security context for the container(s). Optional override, otherwise inherited from the root security context definition          | `{}`                                         |

### *Catalogue Updater*

The *Catalogue Updater* is responsible for updating the catalogue store.
The application settings are defined within the 'topics' key


### *Catalogue Updater* - Application Parameters - Topics

| Name                                       | Description                                                                          | Value                         |
| ------------------------------------------ | ------------------------------------------------------------------------------------ | ----------------------------- |
| `catalogueUpdater.topics.inputTopic`       | The Kafka topic from which the *Catalogue Updater* will consume messages             | `document.textandmetadata`    |
| `catalogueUpdater.topics.outputTopic`      | The Kafka topic to which the *Catalogue Updater* will produce                        | `catalog`                     |
| `catalogueUpdater.topics.debounceWindowMs` | The debounce window in milliseconds                                                  | `30000`                       |
| `catalogueUpdater.topics.flushIntervalMs`  | The flush interval in milliseconds                                                   | `60000`                       |
| `catalogueUpdater.topics.maxBufferSize`    | The maximum buffer size                                                              | `100`                         |
| `catalogueUpdater.topics.dlqTopic`         | The Kafka topic to which the *Catalogue Updater* will produce dead-lettered messages | `document.extractrequest.dlq` |

### *Catalogue Updater* - Common Parameters

| Name                                | Description                                         | Value |
| ----------------------------------- | --------------------------------------------------- | ----- |
| `catalogueUpdater.nameOverride`     | Override the chart name for the *Catalogue Updater* | `""`  |
| `catalogueUpdater.fullnameOverride` | Override the full name for the *Catalogue Updater*  | `""`  |

### *Catalogue Updater* - Deployment Parameters

| Name                                        | Description                                                                                                                        | Value                                          |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `catalogueUpdater.replicas`                 | The number of replicas for the *Catalogue Updater*                                                                                 | `1`                                            |
| `catalogueUpdater.annotations`              | Add extra annotations to the deployment object                                                                                     | `{}`                                           |
| `catalogueUpdater.podAnnotations`           | Annotations to add to the *Catalogue Updater* pods                                                                                 | `{}`                                           |
| `catalogueUpdater.podLabels`                | Labels to add to the *Catalogue Updater* pods                                                                                      | `{}`                                           |
| `catalogueUpdater.extraEnvVars`             | Array with extra environment variables to add                                                                                      | `[]`                                           |
| `catalogueUpdater.extraVolumes`             | Additional volumes for the *Catalogue Updater*                                                                                     | `[]`                                           |
| `catalogueUpdater.extraVolumeMounts`        | Additional volume mounts for the *Catalogue Updater*                                                                               | `[]`                                           |
| `catalogueUpdater.initContainers`           | Add init containers to the pod                                                                                                     | `[]`                                           |
| `catalogueUpdater.sidecars`                 | Add sidecars to the pod.                                                                                                           | `[]`                                           |
| `catalogueUpdater.image.registry`           | *Catalogue Updater* image registry                                                                                                 | `quay.io`                                      |
| `catalogueUpdater.image.repository`         | The container image repository for the *Catalogue Updater*                                                                         | `telicent/telicent-document-catalogue-updater` |
| `catalogueUpdater.image.tag`                | The image tag for the *Catalogue Updater*                                                                                          | `3.3.3`                                        |
| `catalogueUpdater.image.pullPolicy`         | The image pull policy for the *Catalogue Updater*                                                                                  | `IfNotPresent`                                 |
| `catalogueUpdater.image.pullSecrets`        | Secrets for pulling an image from a private repository                                                                             | `[]`                                           |
| `catalogueUpdater.affinity`                 | Affinity rules for the *Catalogue Updater* pods                                                                                    | `{}`                                           |
| `catalogueUpdater.nodeSelector`             | Node selector for the *Catalogue Updater* pods                                                                                     | `{}`                                           |
| `catalogueUpdater.tolerations`              | Tolerations for the *Catalogue Updater* pods                                                                                       | `[]`                                           |
| `catalogueUpdater.resources`                | Resource requests and limits for the *Catalogue Updater*. Optional override, otherwise inherited from the root resource definition | `{}`                                           |
| `catalogueUpdater.podSecurityContext`       | Security context for the pod(s). Optional override, otherwise inherited from the root security context definition                  | `{}`                                           |
| `catalogueUpdater.containerSecurityContext` | Security context for the container(s). Optional override, otherwise inherited from the root security context definition            | `{}`                                           |

### *Content Tagger*

The *Content Tagger* is responsible for tagging documents that have been ingested.
The application settings are defined within the 'topics' key


### *Content Tagger* - Application Parameters - Topics

| Name                                        | Description                                                                | Value                                   |
| ------------------------------------------- | -------------------------------------------------------------------------- | --------------------------------------- |
| `contentTagger.topics.inputTopic`           | The Kafka topic from which the *Content Tagger* will consume messages      | `document.textandmetadata`              |
| `contentTagger.topics.outputTopic`          | The Kafka topic to which the *Content Tagger* will produce                 | `knowledge`                             |
| `contentTagger.topics.rdfTaggerDataUriStub` | The URI for the RDF Tagger service                                         | `http://telicent.io/data#`              |
| `contentTagger.topics.dctUri`               | The URI for Dublin Core Terms                                              | `http://purl.org/dc/terms/`             |
| `contentTagger.topics.iesUri`               | The URI for the IES Ontology                                               | `http://ies.data.gov.uk/ontology/ies4#` |
| `contentTagger.topics.tontUri`              | The URI for the Telicent Ontology                                          | `http://telicent.io/ontology/`          |
| `contentTagger.topics.iso3166Uri`           | The URI for the ISO 3166 standard                                          | `http://iso.org/iso3166/country#`       |
| `contentTagger.topics.loggingLevel`         | The logging level for the *Content Tagger*, e.g., DEBUG, INFO, WARN, ERROR | `INFO`                                  |
| `contentTagger.topics.kafkaConfigMode`      | The configuration mode for Kafka, either 'basic' or 'toml'                 | `toml`                                  |

### *Content Tagger* - Common Parameters

| Name                             | Description                                      | Value |
| -------------------------------- | ------------------------------------------------ | ----- |
| `contentTagger.nameOverride`     | Override the chart name for the *Content Tagger* | `""`  |
| `contentTagger.fullnameOverride` | Override the full name for the *Content Tagger*  | `""`  |

### *Content Tagger* - Deployment Parameters

| Name                                     | Description                                                                                                             | Value                                      |
| ---------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ------------------------------------------ |
| `contentTagger.replicas`                 | The number of replicas for the *Content Tagger*                                                                         | `1`                                        |
| `contentTagger.annotations`              | Add extra annotations to the deployment object                                                                          | `{}`                                       |
| `contentTagger.podLabels`                | Labels to add to the *Content Tagger* pods                                                                              | `{}`                                       |
| `contentTagger.podAnnotations`           | Annotations to add to the *Content Tagger* pods                                                                         | `{}`                                       |
| `contentTagger.extraEnvVars`             | Array with extra environment variables to add                                                                           | `[]`                                       |
| `contentTagger.extraVolumes`             | Additional volumes for the *Content Tagger*                                                                             | `[]`                                       |
| `contentTagger.extraVolumeMounts`        | Additional volume mounts for the *Content Tagger*                                                                       | `[]`                                       |
| `contentTagger.initContainers`           | Add init containers to the pod                                                                                          | `[]`                                       |
| `contentTagger.sidecars`                 | Add sidecars to the pod                                                                                                 | `[]`                                       |
| `contentTagger.image.registry`           | *Content Tagger* image registry                                                                                         | `quay.io`                                  |
| `contentTagger.image.repository`         | The container image repository for the *Content Tagger*                                                                 | `telicent/telicent-rdf-document-tagger-dc` |
| `contentTagger.image.tag`                | The image tag for the *Content Tagger*                                                                                  | `3.0.0`                                    |
| `contentTagger.image.pullPolicy`         | The image pull policy for the *Content Tagger*                                                                          | `IfNotPresent`                             |
| `contentTagger.image.pullSecrets`        | Secrets for pulling an image from a private repository                                                                  | `[]`                                       |
| `contentTagger.affinity`                 | Affinity rules for the *Content Tagger* pods                                                                            | `{}`                                       |
| `contentTagger.nodeSelector`             | Node selector for the *Content Tagger* pods                                                                             | `{}`                                       |
| `contentTagger.tolerations`              | Tolerations for the *Content Tagger* pods                                                                               | `[]`                                       |
| `contentTagger.resources`                | Resource requests and limits for the *Content Tagger*                                                                   | `{}`                                       |
| `contentTagger.podSecurityContext`       | Security context for the pod(s). Optional override, otherwise inherited from the root security context definition       | `{}`                                       |
| `contentTagger.containerSecurityContext` | Security context for the container(s). Optional override, otherwise inherited from the root security context definition | `{}`                                       |

### *Entity Extractor*

The *Entity Extractor* is responsible for extracting entities from the ingested documents.
The application settings are defined within the 'topics' key


### *Entity Extractor* - Application Parameters - Topics

| Name                                     | Description                                                         | Value                      |
| ---------------------------------------- | ------------------------------------------------------------------- | -------------------------- |
| `entityExtractor.topics.inputTopic`      | The Kafka topic from which the content tagger will consume messages | `document.textandmetadata` |
| `entityExtractor.topics.outputTopic`     | The Kafka topic to which the content tagger will produce            | `document.entities`        |
| `entityExtractor.topics.kafkaConfigMode` | The configuration mode for Kafka, either 'basic' or 'toml'          | `toml`                     |

### *Entity Extractor* - Common Parameters

| Name                               | Description                                        | Value |
| ---------------------------------- | -------------------------------------------------- | ----- |
| `entityExtractor.nameOverride`     | Override the chart name for the *Entity Extractor* | `""`  |
| `entityExtractor.fullnameOverride` | Override the full name for the *Entity Extractor*  | `""`  |

### *Entity Extractor* - Deployment Parameters

| Name                                       | Description                                                                                                         | Value                                          |
| ------------------------------------------ | ------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `entityExtractor.replicas`                 | Number of replicas to deploy                                                                                        | `1`                                            |
| `entityExtractor.annotations`              | Add extra annotations to the deployment object                                                                      | `{}`                                           |
| `entityExtractor.podLabels`                | Labels to add to the *Entity Extractor* pods                                                                        | `{}`                                           |
| `entityExtractor.podAnnotations`           | Annotations to add to the *Entity Extractor* pods                                                                   | `{}`                                           |
| `entityExtractor.extraEnvVars`             | Array with extra environment variables to add                                                                       | `[]`                                           |
| `entityExtractor.extraVolumes`             | Additional volumes for the *Entity Extractor*                                                                       | `[]`                                           |
| `entityExtractor.extraVolumeMounts`        | Additional volume mounts for the *Entity Extractor*                                                                 | `[]`                                           |
| `entityExtractor.initContainers`           | Add init containers to the pod                                                                                      | `[]`                                           |
| `entityExtractor.sidecars`                 | Add sidecars to the pod.                                                                                            | `[]`                                           |
| `entityExtractor.image.registry`           | *Entity Extractor* image registry                                                                                   | `quay.io`                                      |
| `entityExtractor.image.repository`         | The container image repository for the *Entity Extractor*                                                           | `telicent/telicent-pipeline-entity-extraction` |
| `entityExtractor.image.tag`                | The image tag for the *Entity Extractor*                                                                            | `3.0.2`                                        |
| `entityExtractor.image.pullPolicy`         | The image pull policy for the *Entity Extractor*                                                                    | `IfNotPresent`                                 |
| `entityExtractor.image.pullSecrets`        | Secrets for pulling an image from a private repository                                                              | `[]`                                           |
| `entityExtractor.affinity`                 | Affinity rules for the *Entity Extractor* pods                                                                      | `{}`                                           |
| `entityExtractor.nodeSelector`             | Node selector for the *Entity Extractor* pods                                                                       | `{}`                                           |
| `entityExtractor.tolerations`              | Tolerations for the *Entity Extractor* pods                                                                         | `[]`                                           |
| `entityExtractor.resources`                | Resources for *Entity Extractor* containers                                                                         | `{}`                                           |
| `entityExtractor.podSecurityContext`       | Security context for the pod(s). Optional override, otherwise inherited from the root security context definition   | `{}`                                           |
| `entityExtractor.containerSecurityContext` | Security context for the container(s). Optional override, otherwise inherited from root security context definition | `{}`                                           |


## License

Copyright &copy; 2025 Telicent Limited
