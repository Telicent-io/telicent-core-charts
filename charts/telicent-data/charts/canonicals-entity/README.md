# Telicent Package for Canonicals Entity

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-data/charts/canonicals-entity
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Global Parameters

Contains global parameters; these parameters are mirrored within the Telicent data umbrella chart
Global values are automatically propagated to every dependency (subchart).
Note: Only global parameters used within this chart will be listed below

| Name                                    | Description                                                                                                       | Value                                          |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `global.imageRegistry`                  | Global image registry                                                                                             | `""`                                           |
| `global.imagePullSecrets`               | Global registry secret names as an array                                                                          | `[]`                                           |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers                                                           | `kafka-bootstrap.kafka.svc.cluster.local:9092` |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration (preferred over individual settings below for security) | `""`                                           |
| `global.kafka.username`                 | Username for Kafka authentication                                                                                 | `""`                                           |
| `global.kafka.password`                 | Password for Kafka authentication                                                                                 | `""`                                           |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                                                                             | `SASL_SSL`                                     |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication                                                                      | `SCRAM-SHA-512`                                |

## License

Copyright &copy; 2026 Telicent Limited
