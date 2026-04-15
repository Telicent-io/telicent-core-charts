# Demo Prerequisite - Kafka UI

A simple Kafka UI Helm chart for demo and development purposes.

## Overview

This chart provisions prerequisites for running the Kafka UI in an instance of the Telicent demo cluster, and then deploys the Kafka UI itself.

> **Note:** This chart is not intended for production use.

## Installation

```bash
helm install my-kafka-ui ./charts/demo-prereqs/charts/kafka-ui \
  --set host=kafka-ui.myhost.com \
  --set idp.host=idp.myhost.com \
  --set idp.jwksEndpoint=https://keycloak.tc-core-dev.svc.cluster.local:8080/realms/core/protocol/openid-connect/certs
```

## Connecting

<!-- markdownlint-disable MD034 -->
Navigate to https://kafka-ui.myhost.com
<!-- markdownlint-enable MD034 -->

> **Note:** This chart requires the Keycloak and PostgreSQL demo prerequisites in order to function.

## Parameters

### Kafka UI Configuration

| Name               | Description                                                            | Value          |
| ------------------ | ---------------------------------------------------------------------- | -------------- |
| `enabled`          | Whether the Kafka UI prerequisite should be installed.                 | `true`         |
| `nameOverride`     | String to partially override fullname (will maintain the release name) | `""`           |
| `fullnameOverride` | String to fully override the generated release name                    | `""`           |
| `host`             | The hostname for the Kafka UI (required)                               | `""`           |
| `istioNamespace`   | The namespace in which to deploy the Kafka UI Istio dependencies       | `istio-system` |

### Ingress Configuration

| Name                      | Description                                                                                                                 | Value     |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------- | --------- |
| `ingress.name`            | The name of the Istio Gateway resource. If left empty, a gateway called `gateways-<kafka-ui.fullname>` will be created      | `""`      |
| `ingress.certificateName` | The name of the secret containing the Kafka UI TLS certificate. If left empty, it will default to `<kafka-ui.fullname>-tls` | `""`      |
| `ingress.port`            | The port on which the Kafka UI service is exposed                                                                           | `80`      |
| `ingress.selectors.istio` | The label selector for the Istio ingress gateway                                                                            | `ingress` |

### IDP Configuration

| Name               | Description                                                   | Value |
| ------------------ | ------------------------------------------------------------- | ----- |
| `idp.host`         | The hostname of the OIDC identity provider (required)         | `""`  |
| `idp.jwksEndpoint` | The name of the endpoint to use for JWKS retrieval (required) | `""`  |

## License

Copyright &copy; 2026 Telicent Limited
