# Demo Prerequisite - Authentication Gateway

A simple Helm chart for demo and development purposes.

## Overview

This chart provision an Istio Gateway and Authentication Policy for an authentication provider running in an instance of the Telicent demo cluster.

> **Note:** This chart is not intended for production use.

## Parameters

### Global Configuration

| Name                | Description                                   | Value          |
| ------------------- | --------------------------------------------- | -------------- |
| `global.namespace`  | The namespace in which the should be created. | `istio-system` |
| `global.tenantName` | The tenant name to apply to the gateway.      | `""`           |
| `global.idpHost`    | The IDP hostname to use in the gateway.       | `""`           |

### Authentication Gateway Configuration

| Name               | Description                                                                                 | Value  |
| ------------------ | ------------------------------------------------------------------------------------------- | ------ |
| `enabled`          | Whether the Authentication Gateway prerequisite should be installed.                        | `true` |
| `nameOverride`     | String to partially override fullname (will maintain the release name).                     | `""`   |
| `fullnameOverride` | String to fully override the generated release name.                                        | `""`   |
| `namespace`        | The namespace in which to deploy OpenSearch. If not set, defaults to the release namespace. | `""`   |

### TLS Configuration

| Name                         | Description                                                                         | Value |
| ---------------------------- | ----------------------------------------------------------------------------------- | ----- |
| `tls.existingCredentialName` | The name of an existing secret containing TLS credentials.                          | `""`  |
| `tls.key`                    | The TLS key to apply to a secret. Ignored when `tls.existingCredentialName` is set. | `""`  |
| `tls.crt`                    | The TLS crt to apply to a secret. Ignored when `tls.existingCredentialName` is set. | `""`  |

### Ingress Configuration

| Name                     | Description                                 | Value     |
| ------------------------ | ------------------------------------------- | --------- |
| `ingressSelectors.istio` | The Istio ingress selector label to target. | `ingress` |

## License

Copyright &copy; 2026 Telicent Limited
