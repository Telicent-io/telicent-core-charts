# Telicent Package for User Preferences API

Telicent User Preferences API allows for testing and demonstrating of Attribute-Based Access Control (ABAC) capabilities within
Telicent CORE.

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

| Name                                  | Description                                                     | Value           |
| ------------------------------------- | --------------------------------------------------------------- | --------------- |
| `global.existingTruststoreSecretName` | is the name of an existing secret containing the truststore     | `""`            |
| `global.istioServiceAccountName`      | The name of the Istio service account to use for the Access API | `istio-ingress` |
| `global.istioNamespace`               | The namespace where Istio is installed                          | `istio-system`  |

### Configuration Parameters

Contains configuration parameters specific to the User Preferences API application

| Name                        | Description                             | Value               |
| --------------------------- | --------------------------------------- | ------------------- |
| `configuration.javaOptions` | are the JVM options for the application | `-Xms512m -Xmx512m` |

### mongo configuration

This section contains the MongoDB configuration for the user preferences service.

| Name                                | Description                                                                                    | Value                                                                                                              |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `mongo.url`                         | is the MongoDB connection string                                                               | `mongodb://mongodb-demo-prereqs-mongodb-svc.mongodb-dev.svc.cluster.local:27017/user-preferences?authSource=admin` |
| `mongo.username`                    | and is used for authentication                                                                 | `user-preferences`                                                                                                 |
| `mongo.password`                    | is the password for the MongoDB user                                                           | `your.mongo.password.here`                                                                                         |
| `mongo.database`                    | is the name of the MongoDB database to use                                                     | `user-preferences`                                                                                                 |
| `mongo.existingMongoPasswordSecret` | If you have an existing secret for the MongoDB password, you can specify it here               | `""`                                                                                                               |
| `fullnameOverride`                  | sets the full name of the chart                                                                | `""`                                                                                                               |
| `nameOverride`                      | sets a custom name for the chart it differs from fullnameOverride as it is not fully qualified | `""`                                                                                                               |
| `annotations`                       | are additional annotations to add to the pod                                                   | `{}`                                                                                                               |
| `replicas`                          | sets the replica count                                                                         | `1`                                                                                                                |
| `resources`                         | sets the resource requests and limits for the pod                                              | `{}`                                                                                                               |
| `revisionHistoryLimit`              | sets the number of old ReplicaSets to retain                                                   | `3`                                                                                                                |

### image configuration

| Name                                                | Description                                                                         | Value                                                                            |
| --------------------------------------------------- | ----------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| `image.pullPolicy`                                  | defines the image pull policy                                                       | `IfNotPresent`                                                                   |
| `image.repository`                                  | is the Docker repository for the image                                              | `098669589541.dkr.ecr.eu-west-2.amazonaws.com/telicent-user-preferences-service` |
| `image.tag`                                         | is the image tag to use appVersion is used by default when defining an empty string | `""`                                                                             |
| `imagePullSecrets`                                  | is a list of secrets to use for pulling the image                                   | `[]`                                                                             |
| `podSecurityContext.fsGroup`                        | sets the filesystem group ID for the pod                                            | `185`                                                                            |
| `podSecurityContext.runAsGroup`                     | sets the group ID for the pod                                                       | `185`                                                                            |
| `podSecurityContext.runAsNonRoot`                   | ensures the pod runs as a non-root user                                             | `true`                                                                           |
| `podSecurityContext.runAsUser`                      | sets the user ID for the pod                                                        | `185`                                                                            |
| `podSecurityContext.seccompProfile.type`            | sets the seccomp profile for the pod                                                | `RuntimeDefault`                                                                 |
| `containerSecurityContext.allowPrivilegeEscalation` | prevents privilege escalation                                                       | `false`                                                                          |
| `containerSecurityContext.capabilities.drop`        | drop all capabilities                                                               | `["ALL"]`                                                                        |
| `containerSecurityContext.runAsGroup`               | sets the group ID for the container                                                 | `185`                                                                            |
| `containerSecurityContext.runAsNonRoot`             | ensures the container runs as a non-root user                                       | `true`                                                                           |
| `containerSecurityContext.runAsUser`                | sets the user ID for the container                                                  | `185`                                                                            |
| `containerSecurityContext.seccompProfile.type`      | defines the seccomp profile type                                                    | `RuntimeDefault`                                                                 |

### metrics configuration

| Name                   | Description                            | Value  |
| ---------------------- | -------------------------------------- | ------ |
| `metrics.service.port` | is the port for the Prometheus service | `9464` |

### serviceAccount configuration

| Name                         | Description                                                                                              | Value |
| ---------------------------- | -------------------------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.annotations` | are additional annotations for the service account                                                       | `{}`  |
| `serviceAccount.name`        | is the name of the service account. If not set, the chart will generate a name based on the release name | `""`  |

### service configuration

| Name                | Description                                 | Value       |
| ------------------- | ------------------------------------------- | ----------- |
| `service.port`      | is the port the service will listen on      | `11111`     |
| `service.type`      | defines the service type                    | `ClusterIP` |
| `ingress.principal` | is the principal to use for ingress traffic | `""`        |
