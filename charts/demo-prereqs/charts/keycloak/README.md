# Demo Prerequisite - Keycloak

A simple Keycloak Helm chart for demo and development purposes.

## Overview

This chart provisions a Keycloak instance in an instance of the Telicent demo cluster.

> **Note:** This chart is not intended for production use.

## Parameters

### Keycloak Configuration

| Name                       | Description                                                                                                  | Value                            |
| -------------------------- | ------------------------------------------------------------------------------------------------------------ | -------------------------------- |
| `enabled`                  | Whether the Keycloak prerequisite should be installed.                                                       | `true`                           |
| `nameOverride`             | String to partially override fullname (will maintain the release name).                                      | `""`                             |
| `fullnameOverride`         | String to fully override the generated release name.                                                         | `""`                             |
| `existingEnvSecret`        | The name of an existing secret containing the admin username and password to use when provisioning Keycloak. | `""`                             |
| `adminUsername`            | The admin username to use when provisioning Keycloak. Ignored if `existingEnvSecret` is set.                 | `admin`                          |
| `adminPassword`            | The admin password to use when provisioning Keycloak. Ignored if `existingEnvSecret` is set.                 | `CHANGE-ADMIN-PASSWORD`          |
| `authGateway`              | The Istio gateway through which ingress to Keycloak must flow.                                               | `istio-system/gateways-authn`    |
| `authHost`                 | The Istio virtual service host for Keycloak.                                                                 | `auth.127.0.0.1.nip.io`          |
| `args`                     | Extra arguments to pass to the Keycloak container.                                                           | `["--proxy-headers=xforwarded"]` |
| `extraEnvVars`             | Array with extra environment variables to add to the Keycloak container.                                     | `[]`                             |
| `resources`                | Set container requests and limits for different resources like CPU or memory.                                | `{}`                             |
| `revisionHistoryLimit`     | Number of controller revisions to keep                                                                       | `3`                              |
| `containerSecurityContext` | Container security context settings to apply to Keycloak containers.                                         | `{}`                             |

### Database Volume Configuration

| Name                    | Description                                          | Value        |
| ----------------------- | ---------------------------------------------------- | ------------ |
| `dbVolume.size`         | The size of the database Persistent Volume.          | `1Gi`        |
| `dbVolume.storageClass` | The StorageClass for the database Persistent Volume. | `local-path` |

### Ingress Configuration

| Name                         | Description                        | Value           |
| ---------------------------- | ---------------------------------- | --------------- |
| `ingress.namespace`          | The Istio ingress namespace.       | `istio-system`  |
| `ingress.serviceAccountName` | The Istio ingress service account. | `istio-ingress` |

### Image Configuration

| Name               | Description                 | Value                       |
| ------------------ | --------------------------- | --------------------------- |
| `image.pullPolicy` | Keycloak image pull policy. | `Always`                    |
| `image.repository` | Keycloak image repository.  | `quay.io/keycloak/keycloak` |

### Pod Security Context Configuration

| Name                 | Description                                              | Value |
| -------------------- | -------------------------------------------------------- | ----- |
| `podSecurityContext` | Pod security context settings to apply to Keycloak pods. | `{}`  |

### Service Configuration

| Name           | Description              | Value       |
| -------------- | ------------------------ | ----------- |
| `service.type` | Kubernetes service port. | `ClusterIP` |
| `service.port` | Kubernetes service type. | `8080`      |

### Service Account Configuration

| Name                         | Description                                                                                           | Value |
| ---------------------------- | ----------------------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.name`        | The name of the ServiceAccount to use. If not set, a name is generated using the `fullname` template. | `""`  |
| `serviceAccount.annotations` | Additional Service Account annotations.                                                               | `{}`  |

### Update Strategy Configuration

| Name                                    | Description                                                                                                  | Value           |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------ | --------------- |
| `strategy.type`                         | Keycloak StatefulSet type                                                                                    | `RollingUpdate` |
| `strategy.rollingUpdate.maxSurge`       | Maximum number of Keycloak pods that can be created above the desired replica count during a rolling update. | `1`             |
| `strategy.rollingUpdate.maxUnavailable` | Maximum number of Keycloak pods that can be unavailable during a rolling update.                             | `0`             |

## License

Copyright &copy; 2026 Telicent Limited
