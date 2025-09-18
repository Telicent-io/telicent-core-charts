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
- Helm 3.8.0+

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

### Service Account

This section builds out the service account more information can be found here: https://kubernetes.io/docs/concepts/security/service-accounts/

| Name                         | Description                                                                                                            | Value  |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                                                  | `true` |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials?                                                                | `true` |
| `serviceAccount.annotations` | Annotations to add to the service account                                                                              | `{}`   |
| `serviceAccount.name`        | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | `""`   |

### HTTP Ingester

This section builds out the HTTP Ingester configuration
The application configuration is contained within the 'configuration' key or can be overriden by providing an existing ConfigMap name

| Name                                                           | Description                                                                                                                                                                                                                                       | Value                                                                                                              |
| -------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `httpIngester.replicaCount`                                    | The number of replicas for the HTTP Ingester                                                                                                                                                                                                      | `1`                                                                                                                |
| `httpIngester.image.repository`                                | The container image repository for the HTTP Ingester                                                                                                                                                                                              | `nginx`                                                                                                            |
| `httpIngester.image.pullPolicy`                                | The image pull policy for the HTTP Ingester                                                                                                                                                                                                       | `IfNotPresent`                                                                                                     |
| `httpIngester.image.tag`                                       | The image tag for the HTTP Ingester                                                                                                                                                                                                               | `""`                                                                                                               |
| `httpIngester.imagePullSecrets`                                | Secrets for pulling an image from a private repository                                                                                                                                                                                            | `[]`                                                                                                               |
| `httpIngester.nameOverride`                                    | Override the chart name for the HTTP Ingester                                                                                                                                                                                                     | `""`                                                                                                               |
| `httpIngester.fullnameOverride`                                | Override the full name for the HTTP Ingester                                                                                                                                                                                                      | `""`                                                                                                               |
| `httpIngester.podAnnotations`                                  | Annotations to add to the HTTP Ingester pods                                                                                                                                                                                                      | `{}`                                                                                                               |
| `httpIngester.podLabels`                                       | Labels to add to the HTTP Ingester pods                                                                                                                                                                                                           | `{}`                                                                                                               |
| `httpIngester.podSecurityContext`                              | Security context for the HTTP Ingester pods                                                                                                                                                                                                       | `{}`                                                                                                               |
| `httpIngester.securityContext`                                 | Security context for the HTTP Ingester containers                                                                                                                                                                                                 | `{}`                                                                                                               |
| `httpIngester.service.type`                                    | The service type for the HTTP Ingester                                                                                                                                                                                                            | `ClusterIP`                                                                                                        |
| `httpIngester.service.port`                                    | The service port for the HTTP Ingester                                                                                                                                                                                                            | `80`                                                                                                               |
| `httpIngester.resources`                                       | Resource requests and limits for the HTTP Ingester                                                                                                                                                                                                | `{}`                                                                                                               |
| `httpIngester.livenessProbe.httpGet.path`                      | The HTTP path for the liveness probe                                                                                                                                                                                                              | `/`                                                                                                                |
| `httpIngester.livenessProbe.httpGet.port`                      | The HTTP port for the liveness probe                                                                                                                                                                                                              | `http`                                                                                                             |
| `httpIngester.readinessProbe.httpGet.path`                     | The HTTP path for the readiness probe                                                                                                                                                                                                             | `/`                                                                                                                |
| `httpIngester.readinessProbe.httpGet.port`                     | The HTTP port for the readiness probe                                                                                                                                                                                                             | `http`                                                                                                             |
| `httpIngester.volumes`                                         | Additional volumes on the output Deployment definition.                                                                                                                                                                                           | `[]`                                                                                                               |
| `httpIngester.volumeMounts`                                    | Additional volumeMounts on the output Deployment definition.                                                                                                                                                                                      | `[]`                                                                                                               |
| `httpIngester.nodeSelector`                                    | Node selector for the HTTP Ingester pods                                                                                                                                                                                                          | `{}`                                                                                                               |
| `httpIngester.tolerations`                                     | Tolerations for the HTTP Ingester pods                                                                                                                                                                                                            | `[]`                                                                                                               |
| `httpIngester.affinity`                                        | Affinity for the HTTP Ingester pods                                                                                                                                                                                                               | `{}`                                                                                                               |
| `httpIngester.existingConfigMapName`                           | If you want to use an existing ConfigMap for configuration then set the name here. If not set then a new ConfigMap will be created using the configuration in this values                                                                         | `""`                                                                                                               |
| `httpIngester.configuration.routes[0].name`                    | A unique name for the route                                                                                                                                                                                                                       | `local`                                                                                                            |
| `httpIngester.configuration.routes[0].topic`                   | The destination Kafka topic for the route                                                                                                                                                                                                         | `ingested_content`                                                                                                 |
| `httpIngester.configuration.routes[0].securityLabel`           | In this test configuration the label is simply test=true                                                                                                                                                                                          | `dGVzdD10cnVl`                                                                                                     |
| `httpIngester.configuration.routes[0].namespace`               | The Namespace URI that will be used to assign a unique URI to a document URIs are generated deterministically based on this and the ingested document content                                                                                     | `https://example.org/ns#`                                                                                          |
| `httpIngester.configuration.routes[0].headers[0].name`         | The Owner header, configured such that even if the header is present in the request then the defaultValue here takes precedence                                                                                                                   | `Owner`                                                                                                            |
| `httpIngester.configuration.routes[0].headers[0].defaultValue` | The default value for the Owner header                                                                                                                                                                                                            | `Platform Team`                                                                                                    |
| `httpIngester.configuration.routes[0].headers[0].priority`     | The priority for the Owner header                                                                                                                                                                                                                 | `CONFIGURATION`                                                                                                    |
| `httpIngester.configuration.routes[0].headers[1].name`         | The (deprecated) Data-Source-Name, configured such that if the header is present in the request then the request value takes precedence                                                                                                           | `Data-Source-Name`                                                                                                 |
| `httpIngester.configuration.routes[0].headers[1].defaultValue` | The default value for the (deprecated) Data-Source-Name header                                                                                                                                                                                    | `Test Data`                                                                                                        |
| `httpIngester.configuration.routes[0].headers[1].priority`     | The priority for the (deprecated) Data-Source-Name header                                                                                                                                                                                         | `REQUEST`                                                                                                          |
| `httpIngester.configuration.routes[0].headers[2].name`         | The Distribution ID header. This is necessary to indicate what data catalogue details are associated to the incoming request. NOTE: marked as REQUEST for time being to make development/testing easier but should be REQUEST_ONLY when deployed. | `Data-Source-Reference`                                                                                            |
| `httpIngester.configuration.routes[0].headers[2].defaultValue` | The default value for the Distribution ID header                                                                                                                                                                                                  | `Telicent Document Pipeline`                                                                                       |
| `httpIngester.configuration.routes[0].headers[2].priority`     | The priority for the Distribution ID header                                                                                                                                                                                                       | `REQUEST`                                                                                                          |
| `httpIngester.configuration.routes[0].headers[3].name`         | The Distribution ID header. This is necessary to indicate what data catalogue details are associated to the incoming request. NOTE: marked as REQUEST for time being to make development/testing easier but should be REQUEST_ONLY when deployed. | `Distribution-Id`                                                                                                  |
| `httpIngester.configuration.routes[0].headers[3].defaultValue` | The default value for the Distribution ID header                                                                                                                                                                                                  | `13bce3bf-7edb-4efb-a54f-574327458dd7`                                                                             |
| `httpIngester.configuration.routes[0].headers[3].priority`     | The priority for the Distribution ID header                                                                                                                                                                                                       | `REQUEST`                                                                                                          |
| `httpIngester.configuration.routes[0].headers[4].name`         | The EDH/IDH policy information header                                                                                                                                                                                                             | `Policy-Information`                                                                                               |
| `httpIngester.configuration.routes[0].headers[4].defaultValue` | The default value for the EDH/IDH policy information header                                                                                                                                                                                       | `{"EDH":{"classification":"O","permittedNats":["GBR"],"permittedOrgs":["Telicent"],"orGroups":[],"andGroups":[]}}` |
| `httpIngester.configuration.routes[0].headers[4].priority`     | The priority for the EDH/IDH policy information header                                                                                                                                                                                            | `REQUEST`                                                                                                          |

### Content Extractor

This section builds out the Content Extractor configuration
The application configuration is contained within the 'configuration' key

| Name                                           | Description                                                            | Value               |
| ---------------------------------------------- | ---------------------------------------------------------------------- | ------------------- |
| `contentExtractor.replicaCount`                | The number of replicas for the Content Extractor                       | `1`                 |
| `contentExtractor.image.repository`            | The container image repository for the Content Extractor               | `nginx`             |
| `contentExtractor.image.pullPolicy`            | The image pull policy for the Content Extractor                        | `IfNotPresent`      |
| `contentExtractor.image.tag`                   | The image tag for the Content Extractor                                | `""`                |
| `contentExtractor.imagePullSecrets`            | Secrets for pulling an image from a private repository                 | `[]`                |
| `contentExtractor.nameOverride`                | Override the chart name for the Content Extractor                      | `""`                |
| `contentExtractor.fullnameOverride`            | Override the full name for the Content Extractor                       | `""`                |
| `contentExtractor.podAnnotations`              | Annotations to add to the Content Extractor pods                       | `{}`                |
| `contentExtractor.podLabels`                   | Labels to add to the Content Extractor pods                            | `{}`                |
| `contentExtractor.podSecurityContext`          | Security context for the Content Extractor pods                        | `{}`                |
| `contentExtractor.securityContext`             | Security context for the Content Extractor containers                  | `{}`                |
| `contentExtractor.service.type`                | The service type for the Content Extractor                             | `ClusterIP`         |
| `contentExtractor.service.port`                | The service port for the Content Extractor                             | `80`                |
| `contentExtractor.resources`                   | Resource requests and limits for the Content Extractor                 | `{}`                |
| `contentExtractor.livenessProbe.httpGet.path`  | The HTTP path for the liveness probe                                   | `/`                 |
| `contentExtractor.livenessProbe.httpGet.port`  | The HTTP port for the liveness probe                                   | `http`              |
| `contentExtractor.readinessProbe.httpGet.path` | The HTTP path for the readiness probe                                  | `/`                 |
| `contentExtractor.readinessProbe.httpGet.port` | The HTTP port for the readiness probe                                  | `http`              |
| `contentExtractor.volumes`                     | Additional volumes for the Content Extractor                           | `[]`                |
| `contentExtractor.volumeMounts`                | Additional volume mounts for the Content Extractor                     | `[]`                |
| `contentExtractor.nodeSelector`                | Node selector for the Content Extractor pods                           | `{}`                |
| `contentExtractor.tolerations`                 | Tolerations for the Content Extractor pods                             | `[]`                |
| `contentExtractor.affinity`                    | Affinity rules for the Content Extractor pods                          | `{}`                |
| `contentExtractor.configuration.inputTopic`    | The Kafka topic from which the content extractor will consume messages | `ingested_content`  |
| `contentExtractor.configuration.outputTopic`   | The Kafka topic to which the content extractor will produce messages   | `extracted_content` |

### Content Indexer

This section builds out the Content Indexer configuration
The application configuration is contained within the 'configuration' key

| Name                                              | Description                                                          | Value                  |
| ------------------------------------------------- | -------------------------------------------------------------------- | ---------------------- |
| `contentIndexer.replicaCount`                     | The number of replicas for the Content Indexer                       | `1`                    |
| `contentIndexer.image.repository`                 | The container image repository for the Content Indexer               | `nginx`                |
| `contentIndexer.image.pullPolicy`                 | The image pull policy for the Content Indexer                        | `IfNotPresent`         |
| `contentIndexer.image.tag`                        | The image tag for the Content Indexer                                | `""`                   |
| `contentIndexer.imagePullSecrets`                 | Secrets for pulling an image from a private repository               | `[]`                   |
| `contentIndexer.nameOverride`                     | Override the chart name for the Content Indexer                      | `""`                   |
| `contentIndexer.fullnameOverride`                 | Override the full name for the Content Indexer                       | `""`                   |
| `contentIndexer.podAnnotations`                   | Annotations to add to the Content Indexer pods                       | `{}`                   |
| `contentIndexer.podLabels`                        | Labels to add to the Content Indexer pods                            | `{}`                   |
| `contentIndexer.podSecurityContext`               | Security context for the Content Indexer pods                        | `{}`                   |
| `contentIndexer.securityContext`                  | Security context for the Content Indexer containers                  | `{}`                   |
| `contentIndexer.service.type`                     | The service type for the Content Indexer                             | `ClusterIP`            |
| `contentIndexer.service.port`                     | The service port for the Content Indexer                             | `80`                   |
| `contentIndexer.resources`                        | Resource requests and limits for the Content Indexer                 | `{}`                   |
| `contentIndexer.livenessProbe.httpGet.path`       | The HTTP path for the liveness probe                                 | `/`                    |
| `contentIndexer.livenessProbe.httpGet.port`       | The HTTP port for the liveness probe                                 | `http`                 |
| `contentIndexer.readinessProbe.httpGet.path`      | The HTTP path for the readiness probe                                | `/`                    |
| `contentIndexer.readinessProbe.httpGet.port`      | The HTTP port for the readiness probe                                | `http`                 |
| `contentIndexer.volumes`                          | Additional volumes for the Content Indexer                           | `[]`                   |
| `contentIndexer.volumeMounts`                     | Additional volume mounts for the Content Indexer                     | `[]`                   |
| `contentIndexer.nodeSelector`                     | Node selector for the Content Indexer pods                           | `{}`                   |
| `contentIndexer.tolerations`                      | Tolerations for the Content Indexer pods                             | `[]`                   |
| `contentIndexer.affinity`                         | Affinity rules for the Content Indexer pods                          | `{}`                   |
| `contentIndexer.configuration.inputTopic`         | The Kafka topic from which the content indexer will consume messages | `extracted_content`    |
| `contentIndexer.configuration.elasticsearchHost`  | The hostname for the Elasticsearch instance                          | `elasticsearch-master` |
| `contentIndexer.configuration.elasticsearchPort`  | The port for the Elasticsearch instance                              | `9200`                 |
| `contentIndexer.configuration.elasticsearchIndex` | The Elasticsearch index to which documents will be indexed           | `documents`            |

### Catalogue Updater

This section builds out the Catalogue Updater configuration
The application configuration is contained within the 'configuration' key

| Name                                              | Description                                                            | Value               |
| ------------------------------------------------- | ---------------------------------------------------------------------- | ------------------- |
| `catalogueUpdater.replicaCount`                   | The number of replicas for the Catalogue Updater                       | `1`                 |
| `catalogueUpdater.image.repository`               | The container image repository for the Catalogue Updater               | `nginx`             |
| `catalogueUpdater.image.pullPolicy`               | The image pull policy for the Catalogue Updater                        | `IfNotPresent`      |
| `catalogueUpdater.image.tag`                      | The image tag for the Catalogue Updater                                | `""`                |
| `catalogueUpdater.imagePullSecrets`               | Secrets for pulling an image from a private repository                 | `[]`                |
| `catalogueUpdater.nameOverride`                   | Override the chart name for the Catalogue Updater                      | `""`                |
| `catalogueUpdater.fullnameOverride`               | Override the full name for the Catalogue Updater                       | `""`                |
| `catalogueUpdater.podAnnotations`                 | Annotations to add to the Catalogue Updater pods                       | `{}`                |
| `catalogueUpdater.podLabels`                      | Labels to add to the Catalogue Updater pods                            | `{}`                |
| `catalogueUpdater.podSecurityContext`             | Security context for the Catalogue Updater pods                        | `{}`                |
| `catalogueUpdater.securityContext`                | Security context for the Catalogue Updater containers                  | `{}`                |
| `catalogueUpdater.service.type`                   | The service type for the Catalogue Updater                             | `ClusterIP`         |
| `catalogueUpdater.service.port`                   | The service port for the Catalogue Updater                             | `80`                |
| `catalogueUpdater.resources`                      | Resource requests and limits for the Catalogue Updater                 | `{}`                |
| `catalogueUpdater.livenessProbe.httpGet.path`     | The HTTP path for the liveness probe                                   | `/`                 |
| `catalogueUpdater.livenessProbe.httpGet.port`     | The HTTP port for the liveness probe                                   | `http`              |
| `catalogueUpdater.readinessProbe.httpGet.path`    | The HTTP path for the readiness probe                                  | `/`                 |
| `catalogueUpdater.readinessProbe.httpGet.port`    | The HTTP port for the readiness probe                                  | `http`              |
| `catalogueUpdater.volumes`                        | Additional volumes for the Catalogue Updater                           | `[]`                |
| `catalogueUpdater.volumeMounts`                   | Additional volume mounts for the Catalogue Updater                     | `[]`                |
| `catalogueUpdater.nodeSelector`                   | Node selector for the Catalogue Updater pods                           | `{}`                |
| `catalogueUpdater.tolerations`                    | Tolerations for the Catalogue Updater pods                             | `[]`                |
| `catalogueUpdater.affinity`                       | Affinity rules for the Catalogue Updater pods                          | `{}`                |
| `catalogueUpdater.configuration.inputTopic`       | The Kafka topic from which the catalogue updater will consume messages | `extracted_content` |
| `catalogueUpdater.configuration.outputTopic`      | The Kafka topic to which the catalogue updater will produce            | `catalogue_updates` |
| `catalogueUpdater.configuration.debounceWindowMs` | The debounce window in milliseconds                                    | `30000`             |
| `catalogueUpdater.configuration.flushIntervalMs`  | The flush interval in milliseconds                                     | `60000`             |
| `catalogueUpdater.configuration.maxBufferSize`    | The maximum buffer size                                                | `100`               |


## License

Copyright &copy; 2025 Telicent Limited
