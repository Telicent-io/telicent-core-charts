# Demo Prerequisite - Kafka

A simple Kafka Helm chart for demo and development purposes.

## Overview

This chart provisions a Kafka cluster and supporting resources in an instance of the Telicent demo cluster, and then deploys the OpenSearch cluster itself.

> **Note:** This chart is not intended for production use.

## Parameters

### Kafka Configuration

| Name               | Description                                                                                 | Value  |
| ------------------ | ------------------------------------------------------------------------------------------- | ------ |
| `enabled`          | Whether the Kafka prerequisite should be installed.                                         | `true` |
| `nameOverride`     | String to partially override fullname (will maintain the release name).                     | `""`   |
| `fullnameOverride` | String to fully override the generated release name.                                        | `""`   |
| `namespace`        | The namespace in which to deploy OpenSearch. If not set, defaults to the release namespace. | `""`   |
| `topics`           | Kafka topics to create on the cluster.                                                      | `[]`   |

### Storage Configuration

| Name              | Description                                                                          | Value |
| ----------------- | ------------------------------------------------------------------------------------ | ----- |
| `storageCapacity` | The storage capacity to apply to the PVC that will be created for the Kafka cluster. | `10G` |

### Credentials Configuration

| Name                        | Description                                                                                                    | Value |
| --------------------------- | -------------------------------------------------------------------------------------------------------------- | ----- |
| `existingUserPwdSecretName` | The name of an existing secret containing the Kafka pipeline, smart-cache and (if enabled) external passwords. | `""`  |
| `pipelinePassword`          | The `pipeline` user password to apply to the Kafka cluster.                                                    | `""`  |
| `smartCachePassword`        | The `smart-cache` user password to apply to the Kafka cluster.                                                 | `""`  |
| `externalPassword`          | The `external` user password to apply to the Kafka cluster.                                                    | `""`  |

### External Access Configuration

| Name                               | Description                                                                         | Value   |
| ---------------------------------- | ----------------------------------------------------------------------------------- | ------- |
| `externalAccess.enabled`           | Whether external access to Kafka is enabled.                                        | `false` |
| `externalAccess.bootstrapHost`     | The external bootstrap hostname/IP. Required if `externalAccess.enabled` is `true`. | `""`    |
| `externalAccess.bootstrapNodePort` | The bootstrap NodePort. Must be in range 30000-32767.                               | `30092` |
| `externalAccess.brokerNodePort`    | The broker NodePort. Must be different from bootstrap nodeport, range 30000-32767.  | `30093` |
| `externalAccess.tls`               | Whether TLS is enabled for the external listener.                                   | `false` |

## License

Copyright &copy; 2026 Telicent Limited
