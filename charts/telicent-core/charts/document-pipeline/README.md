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
Global values are automatically propagated to every dependency (subchart).
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

### smart-cache-documents - HTTP Ingester, Content Extractor, Content Indexer & Catalogue Updater

Values for the `smart-cache-documents` dependency chart. Its value layout matches the previous
top-level httpIngester / contentExtractor / contentIndexer / catalogueUpdater sections of this chart.
Unset values fall back to the dependency chart's own defaults (including container images).

| Name                                                                      | Description                                                                                                            | Value                |
| ------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | -------------------- |
| `smart-cache-documents.enabled`                                           | Enable the smart-cache-documents components                                                                            | `true`               |
| `smart-cache-documents.resources`                                         | Default resources applied to the smart-cache-documents containers                                                      | `{}`                 |
| `smart-cache-documents.podSecurityContext.runAsUser`                      | Set the pod's Security Context runAsUser User ID                                                                       | `185`                |
| `smart-cache-documents.podSecurityContext.runAsGroup`                     | Set the pod's Security Context runAsGroup Group ID                                                                     | `185`                |
| `smart-cache-documents.podSecurityContext.runAsNonRoot`                   | Set the pod's Security Context runAsNonRoot                                                                            | `true`               |
| `smart-cache-documents.podSecurityContext.fsGroup`                        | Set the pod's Group ID for the mounted volumes' filesystem                                                             | `185`                |
| `smart-cache-documents.podSecurityContext.seccompProfile.type`            | Set the pod's Security Context seccomp profile                                                                         | `RuntimeDefault`     |
| `smart-cache-documents.containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                                                                     | `185`                |
| `smart-cache-documents.containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                                                                   | `185`                |
| `smart-cache-documents.containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                                                                          | `true`               |
| `smart-cache-documents.containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                                                              | `false`              |
| `smart-cache-documents.containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                                                                     | `["ALL"]`            |
| `smart-cache-documents.containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                                                                       | `RuntimeDefault`     |
| `smart-cache-documents.serviceAccount.create`                             | Specifies whether a service account should be created                                                                  | `true`               |
| `smart-cache-documents.serviceAccount.automount`                          | Automatically mount a ServiceAccount's API credentials                                                                 | `true`               |
| `smart-cache-documents.serviceAccount.annotations`                        | Annotations to add to the service account                                                                              | `{}`                 |
| `smart-cache-documents.serviceAccount.name`                               | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | `""`                 |
| `smart-cache-documents.hosts.enableAutoCorrect`                           | Allow for the release name to be automatically pre-fixed to each host value when required                              | `true`               |
| `smart-cache-documents.hosts.auth`                                        | Auth application default host value, as defined by 'service/serviceAccount:port'                                       | `auth:8080`          |
| `smart-cache-documents.hosts.traefikProxy`                                | Traefik Proxy application default host value, as defined by 'service/serviceAccount:port'                              | `traefik-proxy:8080` |

### *HTTP Ingester*

| Name                                                                   | Description                                                                                                                                                   | Value                                                                                                              |
| ---------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `smart-cache-documents.httpIngester.java.jvmOptions`                   | Java options to pass to the JVM                                                                                                                               | `-XX:MaxRAMPercentage=80.0`                                                                                        |
| `smart-cache-documents.httpIngester.routes[0].name`                    | A unique name for the route                                                                                                                                   | `local`                                                                                                            |
| `smart-cache-documents.httpIngester.routes[0].topic`                   | The destination Kafka topic for the route                                                                                                                     | `document.extractrequest`                                                                                          |
| `smart-cache-documents.httpIngester.routes[0].securityLabel`           | In this test configuration the label is simply test=true                                                                                                      | `dGVzdD10cnVl`                                                                                                     |
| `smart-cache-documents.httpIngester.routes[0].namespace`               | The Namespace URI that will be used to assign a unique URI to a document URIs are generated deterministically based on this and the ingested document content | `https://example.org/ns#`                                                                                          |
| `smart-cache-documents.httpIngester.routes[0].headers[0].name`         | The Owner header, configured such that even if the header is present in the request then the defaultValue here takes precedence                               | `Owner`                                                                                                            |
| `smart-cache-documents.httpIngester.routes[0].headers[0].defaultValue` | The default value for the Owner header                                                                                                                        | `Platform Team`                                                                                                    |
| `smart-cache-documents.httpIngester.routes[0].headers[0].priority`     | The priority for the Owner header                                                                                                                             | `CONFIGURATION`                                                                                                    |
| `smart-cache-documents.httpIngester.routes[0].headers[1].name`         | The (deprecated) Data-Source-Name, configured such that if the header is present in the request then the request value takes precedence                       | `Data-Source-Name`                                                                                                 |
| `smart-cache-documents.httpIngester.routes[0].headers[1].defaultValue` | The default value for the (deprecated) Data-Source-Name header                                                                                                | `Test Data`                                                                                                        |
| `smart-cache-documents.httpIngester.routes[0].headers[1].priority`     | The priority for the (deprecated) Data-Source-Name header                                                                                                     | `REQUEST`                                                                                                          |
| `smart-cache-documents.httpIngester.routes[0].headers[2].name`         | The Distribution ID header. This is necessary to indicate what data catalogue details are associated to the incoming request.                                 | `Data-Source-Reference`                                                                                            |
| `smart-cache-documents.httpIngester.routes[0].headers[2].defaultValue` | The default value for the Distribution ID header                                                                                                              | `Telicent Document Pipeline`                                                                                       |
| `smart-cache-documents.httpIngester.routes[0].headers[2].priority`     | The priority for the Distribution ID header                                                                                                                   | `REQUEST`                                                                                                          |
| `smart-cache-documents.httpIngester.routes[0].headers[3].name`         | The Distribution ID header.                                                                                                                                   | `Distribution-Id`                                                                                                  |
| `smart-cache-documents.httpIngester.routes[0].headers[3].defaultValue` | The default value for the Distribution ID header                                                                                                              | `13bce3bf-7edb-4efb-a54f-574327458dd7`                                                                             |
| `smart-cache-documents.httpIngester.routes[0].headers[3].priority`     | The priority for the Distribution ID header                                                                                                                   | `REQUEST`                                                                                                          |
| `smart-cache-documents.httpIngester.routes[0].headers[4].name`         | The EDH/IDH policy information header                                                                                                                         | `Policy-Information`                                                                                               |
| `smart-cache-documents.httpIngester.routes[0].headers[4].defaultValue` | The default value for the EDH/IDH policy information header                                                                                                   | `{"EDH":{"classification":"O","permittedNats":["GBR"],"permittedOrgs":["Telicent"],"orGroups":[],"andGroups":[]}}` |
| `smart-cache-documents.httpIngester.routes[0].headers[4].priority`     | The priority for the EDH/IDH policy information header                                                                                                        | `REQUEST`                                                                                                          |
| `smart-cache-documents.httpIngester.configMap.existingEnvConfigMap`    | Name of existing configmap containing *HTTP Ingester* Environment Configuration                                                                               | `""`                                                                                                               |
| `smart-cache-documents.httpIngester.configMap.existingRoutesConfigMap` | Name of existing configmap containing Routes Configuration                                                                                                    | `""`                                                                                                               |
| `smart-cache-documents.httpIngester.replicas`                          | Number of replicas to deploy                                                                                                                                  | `1`                                                                                                                |
| `smart-cache-documents.httpIngester.service.name`                      | *HTTP Ingester* service name. If not set, a name is generated using the fullname                                                                              | `""`                                                                                                               |
| `smart-cache-documents.httpIngester.service.port`                      | *HTTP Ingester* service port                                                                                                                                  | `8080`                                                                                                             |
| `smart-cache-documents.httpIngester.service.type`                      | *HTTP Ingester* service type                                                                                                                                  | `ClusterIP`                                                                                                        |

### *Content Extractor*

| Name                                                        | Description                                                                          | Value                         |
| ----------------------------------------------------------- | ------------------------------------------------------------------------------------ | ----------------------------- |
| `smart-cache-documents.contentExtractor.topics.inputTopic`  | The Kafka topic from which the *Content Extractor* will consume messages             | `document.extractrequest`     |
| `smart-cache-documents.contentExtractor.topics.outputTopic` | The Kafka topic to which the *Content Extractor* will produce messages               | `document.textandmetadata`    |
| `smart-cache-documents.contentExtractor.topics.dlqTopic`    | The Kafka topic to which the *Content Extractor* will produce dead-lettered messages | `document.extractrequest.dlq` |
| `smart-cache-documents.contentExtractor.replicas`           | The number of replicas for the *Content Extractor*                                   | `1`                           |

### *Content Indexer*

| Name                                                                   | Description                                                                        | Value                                        |
| ---------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | -------------------------------------------- |
| `smart-cache-documents.contentIndexer.java.jvmOptions`                 | JVM options for the application                                                    | `-XX:MaxRAMPercentage=80.0`                  |
| `smart-cache-documents.contentIndexer.elastic.host`                    | Elastic/OpenSearch host (include protocol, https or http)                          | `https://your.opensearch.host`               |
| `smart-cache-documents.contentIndexer.elastic.port`                    | Elastic/OpenSearch port number                                                     | `443`                                        |
| `smart-cache-documents.contentIndexer.elastic.opensearchCompatibility` | Enable OpenSearch compatibility                                                    | `true`                                       |
| `smart-cache-documents.contentIndexer.elastic.index`                   | Elastic/OpenSearch index to be used                                                | `doc-content`                                |
| `smart-cache-documents.contentIndexer.elastic.topic`                   | The Kafka topic(s) from which the content indexer will consume messages            | `document.textandmetadata,document.entities` |
| `smart-cache-documents.contentIndexer.elastic.dlqTopic`                | The Kafka topic to which the content indexer will produce dead-lettered messages   | `document.textandmetadata.dlq`               |
| `smart-cache-documents.contentIndexer.elastic.existingSecret`          | Name of an existing secret. The secret must contain 2 keys: 'username', 'password' | `""`                                         |
| `smart-cache-documents.contentIndexer.elastic.username`                | OpenSearch/Elastic username (prefer existingSecret)                                | `""`                                         |
| `smart-cache-documents.contentIndexer.elastic.password`                | OpenSearch/Elastic user password (prefer existingSecret)                           | `""`                                         |
| `smart-cache-documents.contentIndexer.replicas`                        | Number of replicas to deploy                                                       | `1`                                          |

### *Catalogue Updater*

| Name                                                             | Description                                                                          | Value                         |
| ---------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ----------------------------- |
| `smart-cache-documents.catalogueUpdater.topics.inputTopic`       | The Kafka topic from which the *Catalogue Updater* will consume messages             | `document.textandmetadata`    |
| `smart-cache-documents.catalogueUpdater.topics.outputTopic`      | The Kafka topic to which the *Catalogue Updater* will produce                        | `catalog`                     |
| `smart-cache-documents.catalogueUpdater.topics.debounceWindowMs` | The debounce window in milliseconds                                                  | `30000`                       |
| `smart-cache-documents.catalogueUpdater.topics.flushIntervalMs`  | The flush interval in milliseconds                                                   | `60000`                       |
| `smart-cache-documents.catalogueUpdater.topics.maxBufferSize`    | The maximum buffer size                                                              | `100`                         |
| `smart-cache-documents.catalogueUpdater.topics.dlqTopic`         | The Kafka topic to which the *Catalogue Updater* will produce dead-lettered messages | `document.extractrequest.dlq` |
| `smart-cache-documents.catalogueUpdater.replicas`                | The number of replicas for the *Catalogue Updater*                                   | `1`                           |

### rdf-document-tagger-dc - Content Tagger

Values for the `rdf-document-tagger-dc` dependency chart (previously the `contentTagger` section).
This chart flattens its configuration to the top level (topics, image, replicas, ...).
Unset values fall back to the dependency chart's own defaults (including the container image).

| Name                                                                       | Description                                                                               | Value                                   |
| -------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | --------------------------------------- |
| `rdf-document-tagger-dc.enabled`                                           | Enable the Content Tagger component                                                       | `true`                                  |
| `rdf-document-tagger-dc.hosts.enableAutoCorrect`                           | Allow for the release name to be automatically pre-fixed to each host value when required | `true`                                  |
| `rdf-document-tagger-dc.hosts.auth`                                        | Auth application default host value, as defined by 'service/serviceAccount:port'          | `auth:8080`                             |
| `rdf-document-tagger-dc.hosts.traefikProxy`                                | Traefik Proxy application default host value, as defined by 'service/serviceAccount:port' | `traefik-proxy:8080`                    |
| `rdf-document-tagger-dc.topics.inputTopic`                                 | The Kafka topic from which the *Content Tagger* will consume messages                     | `document.textandmetadata`              |
| `rdf-document-tagger-dc.topics.outputTopic`                                | The Kafka topic to which the *Content Tagger* will produce                                | `knowledge`                             |
| `rdf-document-tagger-dc.topics.rdfTaggerDataUriStub`                       | The URI for the RDF Tagger service                                                        | `http://telicent.io/data#`              |
| `rdf-document-tagger-dc.topics.dctUri`                                     | The URI for Dublin Core Terms                                                             | `http://purl.org/dc/terms/`             |
| `rdf-document-tagger-dc.topics.iesUri`                                     | The URI for the IES Ontology                                                              | `http://ies.data.gov.uk/ontology/ies4#` |
| `rdf-document-tagger-dc.topics.tontUri`                                    | The URI for the Telicent Ontology                                                         | `http://telicent.io/ontology/`          |
| `rdf-document-tagger-dc.topics.iso3166Uri`                                 | The URI for the ISO 3166 standard                                                         | `http://iso.org/iso3166/country#`       |
| `rdf-document-tagger-dc.topics.loggingLevel`                               | The logging level for the *Content Tagger*, e.g., DEBUG, INFO, WARN, ERROR                | `INFO`                                  |
| `rdf-document-tagger-dc.topics.kafkaConfigMode`                            | The configuration mode for Kafka, either 'basic' or 'toml'                                | `toml`                                  |
| `rdf-document-tagger-dc.replicas`                                          | The number of replicas for the *Content Tagger*                                           | `1`                                     |
| `rdf-document-tagger-dc.podSecurityContext.runAsUser`                      | Set the pod's Security Context runAsUser User ID                                          | `185`                                   |
| `rdf-document-tagger-dc.podSecurityContext.runAsGroup`                     | Set the pod's Security Context runAsGroup Group ID                                        | `185`                                   |
| `rdf-document-tagger-dc.podSecurityContext.runAsNonRoot`                   | Set the pod's Security Context runAsNonRoot                                               | `true`                                  |
| `rdf-document-tagger-dc.podSecurityContext.fsGroup`                        | Set the pod's Group ID for the mounted volumes' filesystem                                | `185`                                   |
| `rdf-document-tagger-dc.podSecurityContext.seccompProfile.type`            | Set the pod's Security Context seccomp profile                                            | `RuntimeDefault`                        |
| `rdf-document-tagger-dc.containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                                        | `185`                                   |
| `rdf-document-tagger-dc.containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                                      | `185`                                   |
| `rdf-document-tagger-dc.containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                                             | `true`                                  |
| `rdf-document-tagger-dc.containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                                 | `false`                                 |
| `rdf-document-tagger-dc.containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                                        | `["ALL"]`                               |
| `rdf-document-tagger-dc.containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                                          | `RuntimeDefault`                        |

### pipeline-entity-extraction - Entity Extractor

Values for the `pipeline-entity-extraction` dependency chart (previously the `entityExtractor` section).
This chart flattens its configuration to the top level (topics, image, replicas, ...).
Unset values fall back to the dependency chart's own defaults (including the container image).

| Name                                                                           | Description                                                                               | Value                      |
| ------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------- | -------------------------- |
| `pipeline-entity-extraction.enabled`                                           | Enable the Entity Extractor component                                                     | `true`                     |
| `pipeline-entity-extraction.hosts.enableAutoCorrect`                           | Allow for the release name to be automatically pre-fixed to each host value when required | `true`                     |
| `pipeline-entity-extraction.hosts.auth`                                        | Auth application default host value, as defined by 'service/serviceAccount:port'          | `auth:8080`                |
| `pipeline-entity-extraction.hosts.traefikProxy`                                | Traefik Proxy application default host value, as defined by 'service/serviceAccount:port' | `traefik-proxy:8080`       |
| `pipeline-entity-extraction.topics.inputTopic`                                 | The Kafka topic from which the entity extractor will consume messages                     | `document.textandmetadata` |
| `pipeline-entity-extraction.topics.outputTopic`                                | The Kafka topic to which the entity extractor will produce                                | `document.entities`        |
| `pipeline-entity-extraction.topics.kafkaConfigMode`                            | The configuration mode for Kafka, either 'basic' or 'toml'                                | `toml`                     |
| `pipeline-entity-extraction.replicas`                                          | Number of replicas to deploy                                                              | `1`                        |
| `pipeline-entity-extraction.podSecurityContext.runAsUser`                      | Set the pod's Security Context runAsUser User ID                                          | `185`                      |
| `pipeline-entity-extraction.podSecurityContext.runAsGroup`                     | Set the pod's Security Context runAsGroup Group ID                                        | `185`                      |
| `pipeline-entity-extraction.podSecurityContext.runAsNonRoot`                   | Set the pod's Security Context runAsNonRoot                                               | `true`                     |
| `pipeline-entity-extraction.podSecurityContext.fsGroup`                        | Set the pod's Group ID for the mounted volumes' filesystem                                | `185`                      |
| `pipeline-entity-extraction.podSecurityContext.seccompProfile.type`            | Set the pod's Security Context seccomp profile                                            | `RuntimeDefault`           |
| `pipeline-entity-extraction.containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                                        | `185`                      |
| `pipeline-entity-extraction.containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                                      | `185`                      |
| `pipeline-entity-extraction.containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                                             | `true`                     |
| `pipeline-entity-extraction.containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                                 | `false`                    |
| `pipeline-entity-extraction.containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                                        | `["ALL"]`                  |
| `pipeline-entity-extraction.containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                                          | `RuntimeDefault`           |


## License

Copyright &copy; 2026 Telicent Limited
