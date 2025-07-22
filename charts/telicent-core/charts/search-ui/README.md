# Telicent Package for Search UI

Telicent Search UI is an application for searching data in Telicent CORE.

## Introduction

This chart bootstraps Telicent Search UI deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/search-ui
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
 --values=charts/telicent-core/charts/search-ui/values.yaml \
 --readme=charts/telicent-core/charts/search-ui/README.md \
 --schema=charts/telicent-core/charts/search-ui/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                      | Description                                                                       | Value              |
| ------------------------- | --------------------------------------------------------------------------------- | ------------------ |
| `global.imageRegistry`    | Global image registry                                                             | `""`               |
| `global.imagePullSecrets` | Global registry secret names as an array                                          | `[]`               |
| `global.enterprise`       | Enable enterprise mode, adding additional features and configurations             | `false`            |
| `global.appHostDomain`    | Domain associated with Telicent application services                              | `apps.telicent.io` |
| `global.authHostDomain`   | Domain associated with Telicent authentication services, including OIDC providers | `auth.telicent.io` |
| `global.istioNamespace`   | Namespace in which Istio is deployed                                              | `istio-system`     |
| `global.istioGatewayName` | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)         | `istio-ingress`    |

### Configuration Parameters

Contains configuration parameters specific to the Search UI application
If set, it will default to a single vector style from any map service that adheres to the Mapbox style spec.
If set, it can generate multiple layers from any map service that adheres to the Mapbox style spec.

| Name                                        | Description                                                              | Value                           |
| ------------------------------------------- | ------------------------------------------------------------------------ | ------------------------------- |
| `configuration.userPortalUiDeployed`        | If set to true, User Portal links will be available within Search UI     | `true`                          |
| `configuration.graphUiDeployed`             | If set to true, Graph UI links will be available within Search UI        | `true`                          |
| `configuration.dataCatalogUiDeployed`       | If set to true, Data Catalog UI links will be available within Search UI | `true`                          |
| `configuration.signOutUrl`                  | The URL to be used for signing out                                       | `https://your.host.here/logout` |
| `configuration.searchUiMaptilerToken`       | MapTiler token for Search UI                                             | `your.maptiler.token.here`      |
| `configuration.searchUiMapboxStyleSpecUrl`  | Mapbox style spec URL for Search UI                                      | `""`                            |
| `configuration.searchUiArcgisToken`         | ArcGIS token for Search UI                                               | `""`                            |
| `configuration.existingMapConfigSecretName` | The name of an existing secret containing map configuration              | `""`                            |

### Common Parameters

| Name               | Description                                                    | Value |
| ------------------ | -------------------------------------------------------------- | ----- |
| `fullnameOverride` | String to fully override the generated release name            | `""`  |
| `nameOverride`     | String to replace the name of the chart in the Chart.yaml file | `""`  |

### Search UI Deployment Parameters

| Name                                                | Description                                                               | Value                             |
| --------------------------------------------------- | ------------------------------------------------------------------------- | --------------------------------- |
| `replicas`                                          | Number of Search UI replicas to deploy                                    | `1`                               |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                    | `5`                               |
| `image.registry`                                    | Search UI image registry                                                  | `REGISTRY_NAME`                   |
| `image.repository`                                  | Search UI image name                                                      | `REPOSITORY_NAME/telicent-search` |
| `image.tag`                                         | Seearch UI image tag. If not set, a tag is generated using the appVersion | `""`                              |
| `image.pullPolicy`                                  | Search UI image pull policy                                               | `IfNotPresent`                    |
| `imagePullSecrets`                                  | Specify registry secret names as an array                                 | `[]`                              |
| `resources.requests.cpu`                            | Set containers' CPU request                                               | `125m`                            |
| `resources.requests.memory`                         | Set containers' memory request                                            | `512Mi`                           |
| `resources.limits.cpu`                              | Set containers' CPU limit                                                 | `250m`                            |
| `resources.limits.memory`                           | Set containers' memory limit                                              | `768Mi`                           |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                        | `185`                             |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                      | `185`                             |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                             | `true`                            |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                 | `false`                           |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                        | `["ALL"]`                         |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                          | `RuntimeDefault`                  |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID             | `185`                             |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID           | `185`                             |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                  | `true`                            |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem   | `185`                             |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile               | `RuntimeDefault`                  |
| `affinity`                                          | Affinity for pod assignment                                               | `{}`                              |
| `nodeSelector`                                      | Node labels for pod assignment                                            | `{}`                              |
| `tolerations`                                       | Tolerations for pod assignment                                            | `[]`                              |

### Traffic Exposure Parameters

| Name                | Description                                                                                                                                                           | Value       |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| `service.port`      | Search UI service port                                                                                                                                                | `8080`      |
| `service.type`      | Search UI service type                                                                                                                                                | `ClusterIP` |
| `ingress.principal` | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using 'global.istioNamespace' and 'global.istioGatewayName' | `""`        |

### Service Account Parameters

| Name                         | Description                                                                           | Value |
| ---------------------------- | ------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`  |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`  |


## License

Copyright &copy; 2025 Telicent Limited