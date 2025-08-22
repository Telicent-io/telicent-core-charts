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

Contains global parameters, these parameters are mirrored across all Telicent Core sub charts, these values will be authoritative.

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
| `global.kafkaConfigUsername`           | Username for Kafka authentication                                                 | `your.kafka.username.here`                       |
| `global.kafkaConfigPassword`           | Password for Kafka authentication                                                 | `your.kafka.password.here`                       |
| `global.kafkaConfigProtocol`           | Protocol used for Kafka communication                                             | `SASL_SSL`                                       |
| `global.kafkaConfigMechanism`          | SASL mechanism used for Kafka authentication                                      | `SCRAM-SHA-512`                                  |
| `global.existingTruststoreSecretName`  | Name of an existing secret containing the truststore                              | `""`                                             |
| `global.truststore.mountPath`          | The mount path for the truststore in the container                                | `/app/config/truststore`                         |
| `jobServiceAccountName`                | Service account used for running jobs in Kubernetes.                              | `producers`                                      |

### Service Account Parameters

| Name                         | Description                                                                           | Value |
| ---------------------------- | ------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`  |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`  |

## Subchart configurations

This section contains configurations for the various subcharts included in the Telicent Core chart.
Each subchart can be configured independently, allowing for flexibility in deployment.
They are addressed by their names, and each subchart has its own set of configuration parameters.

## License

Copyright &copy; 2025 Telicent Limited
