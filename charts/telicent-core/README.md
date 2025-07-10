# Helm Chart for Telicent Core

Telicent Core is the umbrella chart under which all the subcharts are configured and released.

## Introduction

This chart bootstraps Telicent Core deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core
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
 --values=charts/telicent-core/values.yaml \
 --readme=charts/telicent-core/README.md \
 --schema=charts/telicent-core/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored across all Telicent Core subcharts, these values will be authoritative.

| Name                                   | Description                                                                                                  | Value                                                    |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------- |
| `global.enterprise`                    | Enable enterprise mode, adding additional features and configurations suitable for an enterprise deployment. | `false`                                                  |
| `global.existingKafkaConfigSecretName` | Name of an existing secret containing Kafka configuration                                                    | `""`                                                     |
| `global.kafkaConfigProtocol`           | Protocol used for Kafka communication                                                                        | `SASL_SSL`                                               |
| `global.kafkaConfigMechanism`          | SASL mechanism used for Kafka authentication                                                                 | `SCRAM-SHA-512`                                          |
| `global.kafkaConfigUsername`           | Username for Kafka authentication                                                                            | `your.kafka.username.here`                               |
| `global.kafkaConfigPassword`           | Password for Kafka authentication                                                                            | `your.kafka.password.here`                               |
| `global.appHostDomain`                 | Domain name associated with Telicent Applications                                                            | `apps.yourdomain.com`                                    |
| `global.authHostDomain`                | Domain to be used for interacting with Telicent authentication services, including OIDC providers            | `auth.yourdomain.com`                                    |
| `global.jwksUrl`                       | URL for the JSON Web Key Set (JWKS) used                                                                     | `https://yourdomain.com/.well-known/jwks.json`           |
| `global.kafkaBootstrapUrls`            | List of Kafka bootstrap URLs                                                                                 | `kafka-kafka-bootstrap.kafka-dev.svc.cluster.local:9092` |
| `global.appsGateway`                   | Name of the Istio gateway for applications                                                                   | `istio-system/gateways-apps`                             |
| `global.existingTruststoreSecretName`  | Name of an existing secret containing the truststore                                                         | `""`                                                     |
| `global.truststore.mountPath`          | Mount path for the truststore in the container                                                               | `/app/config/truststore`                                 |
| `jobServiceAccountName`                | Service account used for running jobs in Kubernetes.                                                         | `producers`                                              |

## Subchart configurations 

This section contains configurations for the various subcharts included in the Telicent Core chart.
Each subchart can be configured independently, allowing for flexibility in deployment.
They are addressed by their names, and each subchart has its own set of configuration parameters.

## License

Copyright &copy; 2025 Telicent Limited