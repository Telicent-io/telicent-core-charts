# Demo Prerequisite - Applications Gateway

A simple Helm chart for demo and development purposes.

## Overview

This chart provisions an 0Istio Gateway and Authentication Policy for Telicent CORE applications running in an instance of the Telicent demo cluster.

> **Note:** This chart is not intended for production use.

## Parameters

### Global Configuration

| Name                | Description                                                                   | Value          |
| ------------------- | ----------------------------------------------------------------------------- | -------------- |
| `global.namespace`  | The namespace in which the should be created.                                 | `istio-system` |
| `global.tenantName` | The tenant name to apply to the gateway.                                      | `""`           |
| `global.appsHost`   | The CORE applications hostname to use in the gateway.                         | `""`           |
| `global.apiHost`    | The CORE API hostname to use in the gateway.                                  | `""`           |
| `global.authHost`   | The CORE authentication hostname to use in the gateway.                       | `""`           |
| `global.idpHost`    | The CORE IDP hostname to use in the auto-generated `jwksUri` and `jwtIssuer`. | `""`           |

### Applications Gateway Configuration

| Name               | Description                                                                                                                                                         | Value  |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| `enabled`          | Whether the Applications Gateway prerequisite should be installed.                                                                                                  | `true` |
| `nameOverride`     | String to partially override fullname (will maintain the release name).                                                                                             | `""`   |
| `fullnameOverride` | String to fully override the generated release name.                                                                                                                | `""`   |
| `namespace`        | The namespace in which to deploy OpenSearch. If not set, defaults to the release namespace.                                                                         | `""`   |
| `additionalHosts`  | A list of additional hostnames to use in the apps gateway.                                                                                                          | `[]`   |
| `jwksUri`          | The URI of the JWKS endpoint. Optional, only required if a IDP that differs from that one provided with the Telicent demo prerequisites Helm chart is used is used. | `""`   |
| `jwtIssuer`        | The URI of the JWT issuer. Optional, only required if a IDP that differs from that one provided with the Telicent demo prerequisites Helm chart is used is used.    | `""`   |

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
