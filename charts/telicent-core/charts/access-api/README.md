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
.dev/readme-generator-for-helm --config=charts/telicent-core/readme.config \
 --values=charts/telicent-core/charts/access-api/values.yaml \
 --readme=charts/telicent-core/charts/access-api/README.md \
 --schema=charts/telicent-core/charts/access-api/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                      | Description                                                                       | Value              |
| ------------------------- | --------------------------------------------------------------------------------- | ------------------ |
| `global.imageRegistry`    | Global image registry                                                             | `""`               |
| `global.imagePullSecrets` | Global registry secret names as an array                                          | `[]`               |
| `global.appHostDomain`    | Domain associated with Telicent application services                              | `apps.telicent.io` |
| `global.authHostDomain`   | Domain associated with Telicent authentication services, including OIDC providers | `auth.telicent.io` |
| `global.istioNamespace`   | Namespace in which Istio is deployed                                              | `istio-system`     |
| `global.istioGatewayName` | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)         | `istio-ingress`    |

### Configuration Parameters

Contains configuration parameters specific to the Access API application

| Name                              | Description                  | Value                      |
| --------------------------------- | ---------------------------- | -------------------------- |
| `configuration.debug`             | Enable debug logging         | `true`                     |
| `configuration.openidProviderUrl` | The URL of the OIDC provider | `https://oidc.example.com` |
| `configuration.scimEnabled`       | Enable SCIM user management  | `true`                     |

### Common Parameters

| Name                      | Description                                           | Value |
| ------------------------- | ----------------------------------------------------- | ----- |
| `fullnameOverride`        | String to fully override the generated release name   | `""`  |
| `existingConfigmap`       | Name of the existing configmap for configuration      | `""`  |
| `existingCacertConfigmap` | Name of the existing configmap for extra certificates | `""`  |
| `cacert`                  | Path to the CA certificate file                       | `""`  |

### MongoDB Parameters

| Name                                | Description                                                                                                                                                                    | Value                                         |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------- |
| `mongo.url`                         | MongoDB connection URL                                                                                                                                                         | `mongodb://example.mongodb.net`               |
| `mongo.username`                    | MongoDB username                                                                                                                                                               | `root`                                        |
| `mongo.password`                    | MongoDB password                                                                                                                                                               | `""`                                          |
| `mongo.collection`                  | MongoDB collection                                                                                                                                                             | `access`                                      |
| `mongo.connectionStringOptions`     | MongoDB additional connection values                                                                                                                                           | `authMechanism=SCRAM-SHA-1&retryWrites=false` |
| `mongo.retryRewrites`               | Enable Retryable Writes                                                                                                                                                        | `false`                                       |
| `mongo.existingMongoPasswordSecret` | Existing secret containing the MongoDB password                                                                                                                                | `""`                                          |
| `mongo.existingCaSecret`            | existingCaSecret If you have an existing secret for the CA certificate, you can specify it here. If you've specified to use TLS in the url, you must provide a CA certificate. | `""`                                          |
| `mongo.cacertPath`                  | Path to the CA certificate file, must be set if TLS is enabled in the url and mirror the path in the connectionStringOptions                                                   | `""`                                          |

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
| `resources.requests.cpu`                            | Set containers' CPU request                                               | `250m`                                |
| `resources.requests.memory`                         | Set containers' memory request                                            | `512Mi`                               |
| `resources.limits.cpu`                              | Set containers' CPU limit                                                 | `350m`                                |
| `resources.limits.memory`                           | Set containers' memory limit                                              | `768Mi`                               |
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

| Name                | Description                                                                                                                                                           | Value       |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| `service.port`      | Access API service port                                                                                                                                               | `8080`      |
| `service.type`      | Access API service type                                                                                                                                               | `ClusterIP` |
| `ingress.principal` | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using 'global.istioNamespace' and 'global.istioGatewayName' | `""`        |

### Search API Principal

| Name                  | Description                                                                                                                                                  | Value |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----- |
| `searchApi.principal` | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using the search api name in the current namespace | `""`  |

### Graph Server Principal

| Name                    | Description                                      | Value |
| ----------------------- | ------------------------------------------------ | ----- |
| `graphServer.principal` | is the principal to use for graph server traffic | `""`  |

### Service Account Parameters

| Name                         | Description                                                                           | Value |
| ---------------------------- | ------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`  |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`  |


## License

Copyright &copy; 2025 Telicent Limited