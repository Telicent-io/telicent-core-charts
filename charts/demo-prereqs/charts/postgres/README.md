# Demo Prerequisite - PostgreSQL

A simple PostgreSQL Helm chart for demo and development purposes.

## Overview

This chart deploys a single PostgreSQL instance with persistence support. It is designed for simplicity and a lightweight footprint, making it ideal for local development, demos, and testing environments.

> **Note:** This chart is not intended for production use. For production deployments, consider using a more robust solution like the [Bitnami PostgreSQL chart](https://github.com/bitnami/charts/tree/main/bitnami/postgresql) or a managed database service.

## Installation

```bash
helm install my-postgres ./charts/demo-prereqs-postgres
```

With custom values:

```bash
helm install my-postgres ./charts/demo-prereqs-postgres \
  --set postgres.password=mysecretpassword \
  --set postgres.database=myapp
```

## Connecting

From within the cluster:

```shell
Host: <release-name>-demo-prereqs-postgres.<namespace>.svc.cluster.local
Port: 5432
```

Using port-forward:

```bash
kubectl port-forward svc/<release-name>-demo-prereqs-postgres 5432:5432
psql -h 127.0.0.1 -U postgres -d postgres
```

## Configuration and installation details

## Parameters

### Image

PostgreSQL image configuration

| Name               | Description                                                    | Value          |
| ------------------ | -------------------------------------------------------------- | -------------- |
| `image.repository` | PostgreSQL image repository                                    | `postgres`     |
| `image.pullPolicy` | Image pull policy                                              | `IfNotPresent` |
| `image.tag`        | Overrides the image tag whose default is the chart appVersion. | `""`           |
| `imagePullSecrets` | Specify registry secret names as an array                      | `[]`           |
| `nameOverride`     | Override the name of the chart                                 | `""`           |
| `fullnameOverride` | Override the full name of the chart                            | `""`           |

### PostgreSQL

PostgreSQL configuration

| Name                                 | Description                                                                                                   | Value               |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------- | ------------------- |
| `postgres.database`                  | Database name to create                                                                                       | `postgres`          |
| `postgres.user`                      | Username (superuser)                                                                                          | `postgres`          |
| `postgres.password`                  | Password for the user (required, ignored if existingSecret is set)                                            | `postgres`          |
| `postgres.existingSecret`            | Name of an existing secret containing the postgres password. If set, no secret will be created by this chart. | `""`                |
| `postgres.existingSecretPasswordKey` | Key in the existing secret that contains the postgres password                                                | `postgres-password` |
| `postgres.extraEnv`                  | Additional PostgreSQL configuration parameters                                                                | `[]`                |

### Persistence

Persistence configuration

| Name                       | Description                                       | Value           |
| -------------------------- | ------------------------------------------------- | --------------- |
| `persistence.enabled`      | Enable persistence using Persistent Volume Claims | `true`          |
| `persistence.storageClass` | Storage class - leave empty for default           | `""`            |
| `persistence.accessMode`   | Access mode                                       | `ReadWriteOnce` |
| `persistence.size`         | Size of the persistent volume                     | `1Gi`           |
| `persistence.annotations`  | Annotations for the PVC                           | `{}`            |

### Service

Service configuration

| Name           | Description  | Value       |
| -------------- | ------------ | ----------- |
| `service.type` | Service type | `ClusterIP` |
| `service.port` | Service port | `5432`      |

### Service Account

Service account configuration

| Name                         | Description                        | Value   |
| ---------------------------- | ---------------------------------- | ------- |
| `serviceAccount.create`      | Create a ServiceAccount            | `false` |
| `serviceAccount.automount`   | Automount service account token    | `true`  |
| `serviceAccount.annotations` | Annotations for the ServiceAccount | `{}`    |
| `serviceAccount.name`        | Name of the ServiceAccount         | `""`    |
| `podAnnotations`             | Pod annotations and labels         | `{}`    |
| `podLabels`                  | Pod labels                         | `{}`    |
| `podSecurityContext`         | Security context for the pod       | `{}`    |
| `securityContext`            | Security context for the container | `{}`    |
| `resources`                  | Resource limits and requests       | `{}`    |
| `nodeSelector`               | Node selector                      | `{}`    |
| `tolerations`                | Tolerations                        | `[]`    |
| `affinity`                   | Affinity rules                     | `{}`    |

### Auth

Authentication configuration for Istio AuthorizationPolicy

| Name                             | Description                                                            | Value                |
| -------------------------------- | ---------------------------------------------------------------------- | -------------------- |
| `auth.enabled`                   | Enable Istio AuthorizationPolicy for PostgreSQL connections            | `true`               |
| `auth.namespace`                 | Namespace of the service account allowed to connect                    | `tc-core-dev`        |
| `auth.serviceAccountName`        | Service account name allowed to connect to PostgreSQL                  | `telicent-core-auth` |
| `auth.dbUser`                    | Database role created for the auth database                            | `auth`               |
| `auth.dbPassword`                | Password for the auth database role (ignored if existingSecret is set) | `auth`               |
| `auth.existingSecretPasswordKey` | Key in the existing secret containing the auth db password             | `auth-db-password`   |

### User Preferences

Authentication configuration for Istio AuthorizationPolicy

| Name                                        | Description                                                                        | Value                            |
| ------------------------------------------- | ---------------------------------------------------------------------------------- | -------------------------------- |
| `userPreferences.enabled`                   | Enable Istio AuthorizationPolicy for PostgreSQL connections                        | `true`                           |
| `userPreferences.namespace`                 | Namespace of the service account allowed to connect                                | `tc-core-dev`                    |
| `userPreferences.serviceAccountName`        | Service account name allowed to connect to PostgreSQL                              | `telicent-core-user-preferences` |
| `userPreferences.dbUser`                    | Database role created for the user_preferences database                            | `user_preferences`               |
| `userPreferences.dbPassword`                | Password for the user_preferences database role (ignored if existingSecret is set) | `user_preferences`               |
| `userPreferences.existingSecretPasswordKey` | Key in the existing secret containing the user_preferences db password             | `user-prefs-db-password`         |

## License

Copyright &copy; 2026 Telicent Limited
