# Helm Chart for Telicent Preview

Telicent Preview is the umbrella chart under which all the preview subcharts are configured and released. This repository contains products that are still under development and in preview mode.

## Introduction

This chart bootstraps Telicent Preview deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-preview
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```
The command removes all the Kubernetes components associated with the chart and deletes the release.

## Automating README and schema generation

```bash
.dev/readme-generator-for-helm --config=charts/telicent-preview/readme.config \
 --values=charts/telicent-preview/values.yaml \
 --readme=charts/telicent-preview/README.md \
 --schema=charts/telicent-preview/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored across all Telicent Preview sub charts, these values will be authoritative.

| Name                                    | Description                                                                       | Value                                            |
| --------------------------------------- | --------------------------------------------------------------------------------- | ------------------------------------------------ |
| `global.imageRegistry`                  | Global image registry                                                             | `""`                                             |
| `global.imagePullSecrets`               | Global registry secret names as an array                                          | `[]`                                             |
| `global.enterprise`                     | Enable enterprise mode, adding additional features and configurations             | `false`                                          |
| `global.appHostDomain`                  | Domain associated with Telicent application services                              | `apps.telicent.io`                               |
| `global.authHostDomain`                 | Domain associated with Telicent authentication services, including OIDC providers | `auth.telicent.io`                               |
| `global.groupsClaim`                    | Key used to retrieve groups from the OIDC provider                                | `groups`                                         |
| `global.jwksUrl`                        | Endpoint exposing multiple public keys represented as JWKs (JSON Web Key Set)     | `https://{yourAuthdomain}/.well-known/jwks.json` |
| `global.istioNamespace`                 | Namespace in which Istio is deployed                                              | `istio-system`                                   |
| `global.istioServiceAccountName`        | Name of the Istio service account                                                 | `istio-ingress`                                  |
| `global.istioGatewayName`               | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)         | `ingress-gateway`                                |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers                           | `kafka-bootstrap.kafka.svc.cluster.local:9092`   |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration                         | `""`                                             |
| `global.kafka.username`                 | Username for Kafka authentication                                                 | `your.kafka.username.here`                       |
| `global.kafka.password`                 | Password for Kafka authentication                                                 | `your.kafka.password.here`                       |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                                             | `SASL_SSL`                                       |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication                                      | `SCRAM-SHA-512`                                  |
| `global.existingTruststoreSecretName`   | Name of an existing secret containing the truststore                              | `""`                                             |
| `global.truststore.mountPath`           | The mount path for the truststore in the container                                | `/app/config/truststore`                         |

### paperback-writer Parameters

| Name                       | Description                                      | Value  |
| -------------------------- | ------------------------------------------------ | ------ |
| `paperback-writer.enabled` | Enable or disable the paperback-writer component | `true` |

### data-catalog Parameters

| Name                   | Description                                  | Value  |
| ---------------------- | -------------------------------------------- | ------ |
| `data-catalog.enabled` | Enable or disable the data-catalog component | `true` |

## Subchart configurations

This section contains configurations for the various preview subcharts included in the Telicent Preview chart.
Each subchart can be configured independently, allowing for flexibility in deployment.
They are addressed by their names, and each subchart has its own set of configuration parameters.

## License

Copyright &copy; 2025 Telicent Limited
