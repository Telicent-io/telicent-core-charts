# Helm Chart for Telicent Core

Telicent Core is the umbrella chart under which all the subcharts are configured and released.

## Introduction

This chart bootstraps Telicent Telicent Core deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/access-api
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
 --values=charts/telicent-core/charts/access-api/values.yaml \
 --readme=charts/telicent-core/charts/access-api/README.md \
 --schema=charts/telicent-core/charts/access-api/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored across all Telicent Core subcharts, these values will be authoritative.

| Name                                   | Description                                                                                                                                                   | Value                                                    |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| `global.enterprise`                    | If set to true, the chart will be configured for enterprise use, This will enable additional features and configurations suitable for enterprise deployments. | `false`                                                  |
| `global.existingKafkaConfigSecretName` | is the name of an existing secret containing Kafka configuration                                                                                              | `""`                                                     |
| `global.kafkaConfigProtocol`           | is the protocol used for Kafka communication                                                                                                                  | `SASL_SSL`                                               |
| `global.kafkaConfigMechanism`          | is the SASL mechanism used for Kafka authentication                                                                                                           | `SCRAM-SHA-512`                                          |
| `global.kafkaConfigUsername`           | is the username for Kafka authentication                                                                                                                      | `your.kafka.username.here`                               |
| `global.kafkaConfigPassword`           | is the password for Kafka authentication                                                                                                                      | `your.kafka.password.here`                               |
| `global.appHostDomain`                 | is the domain for the Telicent applications                                                                                                                   | `apps.yourdomain.com`                                    |
| `global.authHostDomain`                | is the domain for the Telicent authentication service                                                                                                         | `auth.yourdomain.com`                                    |
| `global.jwksUrl`                       | is the URL for the JSON Web Key Set (JWKS) used                                                                                                               | `https://yourdomain.com/.well-known/jwks.json`           |
| `global.kafkaBootstrapUrls`            | is the list of Kafka bootstrap URLs                                                                                                                           | `kafka-kafka-bootstrap.kafka-dev.svc.cluster.local:9092` |
| `global.appsGateway`                   | is the name of the Istio gateway for applications                                                                                                             | `istio-system/gateways-apps`                             |
| `global.existingTruststoreSecretName`  | The name of an existing secret containing the truststore                                                                                                      | `""`                                                     |
| `global.truststore.mountPath`          | The mount path for the truststore in the container                                                                                                            | `/app/config/truststore`                                 |

## Subchart configurations 

This section contains configurations for the various subcharts included in the Telicent Core chart.
Each subchart can be configured independently, allowing for flexibility in deployment.
They are addressed by their names, and each subchart has its own set of configuration parameters.

## License

Copyright &copy; 2025 Telicent Limited