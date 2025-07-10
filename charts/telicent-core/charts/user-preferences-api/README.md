# Copyright (C) 2025 Telicent Limited
# Telicent Package for User Preferences API

Telicent User Preferences API enables sharing of user preferences and data across Telicent Applications.

## Introduction

This chart bootstraps Telicent User Preferences API deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/user-preferences-api
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
 --values=charts/telicent-core/charts/user-preferences-api/values.yaml \
 --readme=charts/telicent-core/charts/user-preferences-api/README.md \
 --schema=charts/telicent-core/charts/user-preferences-api/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                                  | Description                                                           | Value           |
| ------------------------------------- | --------------------------------------------------------------------- | --------------- |
| `global.imageRegistry`                | Global image registry                                                 | `""`            |
| `global.imagePullSecrets`             | Global registry secret names as an array                              | `[]`            |
| `global.existingTruststoreSecretName` | Name of an existing secret containing the truststore                  | `""`            |
| `global.istioServiceAccountName`      | Name of the Istio service account to use for the User Preferences API | `istio-ingress` |
| `global.istioNamespace`               | Istio Namespace where Istio is installed                              | `istio-system`  |

### Configuration Parameters

Contains configuration parameters specific to the User Preferences API application

| Name                        | Description                     | Value               |
| --------------------------- | ------------------------------- | ------------------- |
| `configuration.javaOptions` | JVM options for the application | `-Xms512m -Xmx512m` |

### MongoDB Parameters

| Name                                | Description                                                                                                                                                   | Value                                                                                                              |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `mongo.url`                         | MongoDB connection URL                                                                                                                                        | `mongodb://mongodb-demo-prereqs-mongodb-svc.mongodb-dev.svc.cluster.local:27017/user-preferences?authSource=admin` |
| `mongo.username`                    | MongoDB username                                                                                                                                              | `user-preferences`                                                                                                 |
| `mongo.password`                    | MongoDB password                                                                                                                                              | `your.mongo.password.here`                                                                                         |
| `mongo.database`                    | MongoDB database                                                                                                                                              | `user-preferences`                                                                                                 |
| `mongo.existingMongoPasswordSecret` | Existing secret containing the MongoDB password                                                                                                               | `""`                                                                                                               |
| `mongo.existingCaSecret`            | If you have an existing secret for the CA certificate, you can specify it here. If you've specified to use TLS in the url, you must provide a CA certificate. | `""`                                                                                                               |
| `mongo.cacertPath`                  | Path to the CA certificate file, must be set if TLS is enabled in the url and mirror the path in the connectionStringOptions                                  | `""`                                                                                                               |

### User Preferences API Deployment Parameters

| Name                                                | Description                                                                         | Value                                               |
| --------------------------------------------------- | ----------------------------------------------------------------------------------- | --------------------------------------------------- |
| `replicas`                                          | Number of User Preferences API replicas to deploy                                   | `1`                                                 |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                              | `5`                                                 |
| `annotations`                                       | Add extra annotations to the Deployment object                                      | `{}`                                                |
| `image.registry`                                    | User Preferences API image registry                                                 | `REGISTRY_NAME`                                     |
| `image.repository`                                  | User Preferences API image name                                                     | `REPOSITORY_NAME/telicent-user-preferences-service` |
| `image.tag`                                         | User Preferences API image tag. If not set, a tag is generated using the appVersion | `""`                                                |
| `image.pullPolicy`                                  | User Preferences API image pull policy                                              | `IfNotPresent`                                      |
| `image.pullSecrets`                                 | Specify registry secret names as an array                                           | `[]`                                                |
| `resources.requests.cpu`                            | Set containers' CPU request                                                         | `100m`                                              |
| `resources.requests.memory`                         | Set containers' memory request                                                      | `768Mi`                                             |
| `resources.limits.cpu`                              | Set containers' CPU limit                                                           | `250m`                                              |
| `resources.limits.memory`                           | Set containers' memory limit                                                        | `1024Mi`                                            |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                                  | `185`                                               |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                                | `185`                                               |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                                       | `true`                                              |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                           | `false`                                             |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                                  | `["ALL"]`                                           |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                                    | `RuntimeDefault`                                    |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID                       | `185`                                               |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID                     | `185`                                               |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                            | `true`                                              |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem             | `185`                                               |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile                         | `RuntimeDefault`                                    |

### Metrics Parameters

| Name                   | Description                     | Value     |
| ---------------------- | ------------------------------- | --------- |
| `metrics.service.port` | Port for the Prometheus service | `9464`    |
| `metrics.service.name` | Name for the Prometheus service | `metrics` |

### Traffic Exposure Parameters

| Name                | Description                                                                                                 | Value       |
| ------------------- | ----------------------------------------------------------------------------------------------------------- | ----------- |
| `service.port`      | User Preferences API service port                                                                           | `11111`     |
| `service.type`      | User Preferences API service type                                                                           | `ClusterIP` |
| `ingress.principal` | Principal to use for ingress traffic. If not set, defaults to the Istio service account in the istio-system | `""`        |

### Service Account Parameters

| Name                         | Description                                                                                     | Value |
| ---------------------------- | ----------------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.name`        | Name of the created ServiceAccount. If not set, a name is generated using the fullname template | `""`  |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                            | `{}`  |


## License

Copyright &copy; 2025 Telicent Limited
