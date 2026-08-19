# Helm Chart for Telicent Core

Telicent Core is the umbrella chart under which all the subcharts are configured and released.

## Introduction

This chart bootstraps Telicent Core deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core
```

**⚠️ IMPORTANT:** Before deploying, you must configure Kafka credentials. See [CONFIGURATION.md](./CONFIGURATION.md) for detailed setup instructions.

The chart will fail validation if placeholder values are detected or required credentials are missing.

## Upgrading

### To 2.0.0

This release bumps the platform and front-end subcharts to their 2.0.0 platform
versions. Review the individual subchart changelogs before upgrading:

| Subchart | From | To |
| --- | --- | --- |
| `admin-ui` | 1.6.0 | 1.7.1 |
| `auth` | 0.2.9 | 0.3.1 |
| `graph` | 1.0.9 | 1.1.4 |
| `graph-ui` | 1.38.2 | 1.39.0 |
| `search` | 2.2.0 | 2.2.6 |
| `search-projector` | 2.2.0 | 2.2.6 |
| `search-ui` | 4.21.0 | 4.22.1 |
| `document-pipeline` | 0.2.4 | 0.2.5 |
| `user-preferences` | 0.2.3 | 0.2.4 |

`document-pipeline` additionally moves its own dependency from 3.5.1 to 4.0.2, and
`user-preferences` moves its `appVersion` from 2.0.8 to 2.0.10.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Automating README and schema generation

```bash
.dev/readme-generator-for-helm --config=charts/telicent-core/readme.config \
 --values=charts/telicent-core/values.yaml \
 --readme=charts/telicent-core/README.md \
 --schema=charts/telicent-core/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters - Common

Contains global parameters, these parameters are mirrored across all Telicent Core sub charts, these values will be authoritative.

| Name                      | Description                                                           | Value   |
| ------------------------- | --------------------------------------------------------------------- | ------- |
| `global.imageRegistry`    | Global image registry                                                 | `""`    |
| `global.imagePullSecrets` | Global registry secret names as an array                              | `[]`    |
| `global.enterprise`       | Enable enterprise mode, adding additional features and configurations | `false` |

### Global Parameters - Domains

| Name                    | Description                                                                                                                     | Value |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `global.appHostDomain`  | Domain associated with Telicent application/ui services. This value cannot be changed after it is set                           | `""`  |
| `global.apiHostDomain`  | Domain associated with Telicent Api services. This value cannot be changed after it is set                                      | `""`  |
| `global.authHostDomain` | Domain associated with Telicent authentication services, including OIDC providers. This value cannot be changed after it is set | `""`  |

### Global Parameters - Istio

These settings will be used by all Telicent Core components using Istio resources.

| Name                                | Description                                               | Value             |
| ----------------------------------- | --------------------------------------------------------- | ----------------- |
| `global.istioIngressNamespace`      | Namespace in which the Istio Ingress resource is deployed | `istio-system`    |
| `global.istioIngressServiceAccount` | ServiceAccount associated with Istio ingress deployment   | `istio-ingress`   |
| `global.istioGatewayNamespace`      | Namespace in which the Istio Gateway resource is deployed | `istio-system`    |
| `global.istioGatewayName`           | Name of the Istio Gateway resource                        | `ingress-gateway` |

### Global Parameters - Kafka

Kafka configuration parameters. These settings will be used by all Telicent Core components that interact
with Kafka, ensuring consistent connectivity and authentication across the platform.

| Name                                    | Description                                               | Value                                          |
| --------------------------------------- | --------------------------------------------------------- | ---------------------------------------------- |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers   | `kafka-bootstrap.kafka.svc.cluster.local:9092` |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration | `""`                                           |
| `global.kafka.username`                 | Username for Kafka authentication                         | `your.kafka.username.here`                     |
| `global.kafka.password`                 | Password for Kafka authentication                         | `your.kafka.password.here`                     |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                     | `SASL_SSL`                                     |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication              | `SCRAM-SHA-512`                                |

### Global Parameters - Truststore

Contains global truststore parameters, these parameters are mirrored across Telicent Core sub charts.

| Name                               | Description                                          | Value                    |
| ---------------------------------- | ---------------------------------------------------- | ------------------------ |
| `global.truststore.existingSecret` | Name of an existing secret containing the truststore | `""`                     |
| `global.truststore.mountPath`      | The mount path for the truststore in the container   | `/app/config/truststore` |

### Service Account Parameters

| Name                         | Description                                                                           | Value |
| ---------------------------- | ------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`  |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`  |

### Jobs Parameters

| Name                    | Description                                          | Value       |
| ----------------------- | ---------------------------------------------------- | ----------- |
| `jobServiceAccountName` | Service account used for running jobs in Kubernetes. | `producers` |

### Kafka Topics Parameters

| Name                            | Description                                                                                                         | Value   |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------- |
| `kafkaTopics.enabled`           | Enable or disable the creation of Kafka topics during installation                                                  | `false` |
| `kafkaTopics.topics`            | List of Kafka topics to be created                                                                                  | `[]`    |
| `istioInjectionLabelJobEnabled` | Enable automatically labelling a namespace for Istio injection via a job. Useful when namespace is created via Helm | `true`  |

## Subchart configurations

This section contains configurations for the various subcharts included in the Telicent Core chart.
Each subchart can be configured independently, allowing for flexibility in deployment.
They are addressed by their names, and each subchart has its own set of configuration parameters.

| Name              | Description | Link                                                      |
|-------------------|-------------|-----------------------------------------------------------|
| Admin UI          | Administrative interface for managing Telicent Core components | [admin-ui](./charts/admin-ui/README.md)                    |
| Auth              | Authentication broker providing OAuth/OIDC integration | [auth](./charts/auth/README.md)                           |
| Document Pipeline | Document processing and ingestion pipeline | [document-pipeline](./charts/document-pipeline/README.md) |
| Graph             | RDF graph database and SPARQL query engine | [graph](./charts/graph/README.md)                         |
| Graph UI          | Visual graph exploration and query interface | [graph-ui](./charts/graph-ui/README.md)                   |
| Query UI          | SPARQL query interface for graph data | [query-ui](./charts/query-ui/README.md)                   |
| Search            | Search backend service with indexing capabilities | [search](./charts/search/README.md)                       |
| Search Projector  | Kafka-to-search indexing service | [search-projector](./charts/search-projector/README.md)   |
| Search UI         | Search interface for discovering and exploring data | [search-ui](./charts/search-ui/README.md)                 |
| Traefik Proxy     | Reverse proxy for internal service routing | [traefik-proxy](charts/traefik-proxy/README.md)           |
| User Preferences  | User settings and preferences management service | [user-preferences](./charts/user-preferences/README.md)   |

## License

Copyright &copy; 2026 Telicent Limited
