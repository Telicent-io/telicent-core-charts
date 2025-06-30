# Telicent Package for Access API

Telicent Access API allows for testing and demonstrating of Attribute-Based Access Control (ABAC) capabilities within
Telicent CORE.

## Introduction

This chart bootstraps Telicent Access API deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/access-api
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```
The command removes all the Kubernetes components associated with the chart and deletes the release.

## Automating README and schema generation

```bash
_dev/readme-generator-for-helm --config=charts/telicent-core/readme.config \
 --values=charts/telicent-core/charts/access-api/values.yaml \
 --readme=charts/telicent-core/charts/access-api/README.md \
 --schema=charts/telicent-core/charts/access-api/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                      | Description                                                                                       | Value              |
| ------------------------- | ------------------------------------------------------------------------------------------------- | ------------------ |
| `global.imageRegistry`    | Global image registry                                                                             | `""`               |
| `global.imagePullSecrets` | Global registry secret names as an array                                                          | `[]`               |
| `global.appHostDomain`    | Domain name associated with Access API                                                            | `apps.telicent.io` |
| `global.authHostDomain`   | Domain to be used for interacting with Telicent authentication services, including OIDC providers | `auth.telicent.io` |

### Configuration Parameters

Contains configuration parameters specific to the Access API application

| Name                              | Description                  | Value                      |
| --------------------------------- | ---------------------------- | -------------------------- |
| `configuration.debug`             | Enable debug logging         | `true`                     |
| `configuration.openidProviderUrl` | The URL of the OIDC provider | `https://oidc.example.com` |
| `configuration.scimEnabled`       | Enable SCIM user management  | `true`                     |

### Common Parameters

| Name                      | Description                                               | Value |
| ------------------------- | --------------------------------------------------------- | ----- |
| `fullnameOverride`        | String to fully override the generated release name       | `""`  |
| `existingConfigmap`       | The name of the existing configmap for configuration      | `""`  |
| `existingCacertConfigmap` | The name of the existing configmap for extra certificates | `""`  |
| `cacert`                  | Path to the CA certificate file                           | `""`  |

### MongoDB Parameters

| Name                                | Description                                     | Value                                         |
| ----------------------------------- | ----------------------------------------------- | --------------------------------------------- |
| `mongo.url`                         | MongoDB connection URL                          | `mongodb://example.mongodb.net`               |
| `mongo.username`                    | MongoDB username                                | `root`                                        |
| `mongo.password`                    | MongoDB password                                | `""`                                          |
| `mongo.collection`                  | MongoDB collection                              | `access`                                      |
| `mongo.connectionStringOptions`     | MongoDB additional connection values            | `authMechanism=SCRAM-SHA-1&retryWrites=false` |
| `mongo.retryRewrites`               | Enable Retryable Writes                         | `false`                                       |
| `mongo.existingMongoPasswordSecret` | Existing secret containing the MongoDB password | `""`                                          |

### Access API Deployment Parameters

| Name                                                | Description                                                               | Value                                 |
| --------------------------------------------------- | ------------------------------------------------------------------------- | ------------------------------------- |
| `replicas`                                          | Number of Access API replicas to deploy                                   | `1`                                   |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                    | `5`                                   |
| `image.registry`                                    | Access API image registry                                                 | `REGISTRY_NAME`                       |
| `image.repository`                                  | Access API image name                                                     | `REPOSITORY_NAME/telicent-access-api` |
| `image.tag`                                         | Access API image tag. If not set, a tag is generated using the appVersion | `""`                                  |
| `image.pullPolicy`                                  | Access API image pull policy                                              | `IfNotPresent`                        |
| `image.pullSecrets`                                 | Specify registry secret names as an array                                 | `[]`                                  |
| `resources.requests.cpu`                            | Set containers' CPU request                                               | `500m`                                |
| `resources.requests.memory`                         | Set containers' memory request                                            | `512Mi`                               |
| `resources.limits.cpu`                              | Set containers' CPU limit                                                 | `1`                                   |
| `resources.limits.memory`                           | Set containers' memory limit                                              | `1Gi`                                 |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                        | `185`                                 |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                      | `185`                                 |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                             | `true`                                |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                 | `false`                               |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                        | `["ALL"]`                             |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                          | `RuntimeDefault`                      |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID             | `185`                                 |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID           | `185`                                 |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                  | `true`                                |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem   | `185`                                 |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile               | `RuntimeDefault`                      |

### Traffic Exposure Parameters

| Name           | Description             | Value       |
| -------------- | ----------------------- | ----------- |
| `service.port` | Access API service port | `8080`      |
| `service.type` | Access API service type | `ClusterIP` |

### Other Parameters

| Name                         | Description                                                                                     | Value |
| ---------------------------- | ----------------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.name`        | Name of the created ServiceAccount. If not set, a name is generated using the fullname template | `""`  |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                            | `{}`  |

