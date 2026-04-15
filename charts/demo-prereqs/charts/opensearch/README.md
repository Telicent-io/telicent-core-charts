# Demo Prerequisite - OpenSearch

A simple OpenSearch Helm chart for demo and development purposes.

## Overview

This chart provisions prerequisites for running an OpenSearch cluster in an instance of the Telicent demo cluster, and then deploys the OpenSearch cluster itself.

> **Note:** This chart is not intended for production use.

## Installation

```bash
helm install my-opensearch ./charts/demo-prereqs/charts/opensearch \
  --set host=kafka-ui.myhost.com \
  --set idp.host=idp.myhost.com \
  --set idp.jwksEndpoint=https://keycloak.tc-core-dev.svc.cluster.local:8080/realms/core/protocol/openid-connect/certs
```

## Parameters

### OpenSearch Configuration

| Name               | Description                                                                                 | Value  |
| ------------------ | ------------------------------------------------------------------------------------------- | ------ |
| `enabled`          | Whether the OpenSearch prerequisite should be installed.                                    | `true` |
| `nameOverride`     | String to partially override fullname (will maintain the release name).                     | `""`   |
| `fullnameOverride` | String to fully override the generated release name.                                        | `""`   |
| `namespace`        | The namespace in which to deploy OpenSearch. If not set, defaults to the release namespace. | `""`   |

### OpenSearch Users Secret Configuration

| Name                       | Description                                                                                                                      | Value             |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| `secret.name`              | The name to use when creating the Kubernetes secret containing the OpenSearch credentials. If not set, defaults to `<fullname>`. | `""`              |
| `secret.adminUserName`     | The name of the admin user to create in the OpenSearch cluster.                                                                  | `admin`           |
| `secret.adminUserPassword` | The password for the admin OpenSearch user.                                                                                      | `""`              |
| `secret.userName`          | The name of the non-admin user to create in the OpenSearch cluster.                                                              | `telicent-search` |
| `secret.userPassword`      | The password for the non-admin OpenSearch user.                                                                                  | `""`              |

## License

Copyright &copy; 2026 Telicent Limited
