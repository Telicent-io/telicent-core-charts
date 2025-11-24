# Telicent Package for Graph UI

Telicent Graph UI is an application for querying data in Telicent CORE.

## Introduction

This chart bootstraps Telicent Graph UI deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/graph-ui
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
 --values=charts/telicent-core/charts/graph-ui/values.yaml \
 --readme=charts/telicent-core/charts/graph-ui/README.md \
 --schema=charts/telicent-core/charts/graph-ui/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                                | Description                                                                       | Value              |
| ----------------------------------- | --------------------------------------------------------------------------------- | ------------------ |
| `global.imageRegistry`              | Global image registry                                                             | `""`               |
| `global.imagePullSecrets`           | Global registry secret names as an array                                          | `[]`               |
| `global.enterprise`                 | Enable enterprise mode, adding additional features and configurations             | `false`            |
| `global.appHostDomain`              | Domain associated with Telicent application/ui services                           | `apps.telicent.io` |
| `global.apiHostDomain`              | Domain associated with Telicent Api services                                      | `api.telicent.io`  |
| `global.authHostDomain`             | Domain associated with Telicent authentication services, including OIDC providers | `auth.telicent.io` |
| `global.istioNamespace`             | Namespace in which Istio is deployed                                              | `istio-system`     |
| `global.istioServiceAccountName`    | Name of the Istio service account                                                 | `istio-ingress`    |
| `global.istioGatewayName`           | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)         | `ingress-gateway`  |
| `global.istioVirtualServiceEnabled` | Enable Istio traffic routing to a named destination service                       | `false`            |

### Configuration Parameters

Contains configuration parameters specific to the *Graph UI* application

| Name                                        | Description                                                                 | Value                      |
| ------------------------------------------- | --------------------------------------------------------------------------- | -------------------------- |
| `configuration.userPortalUiDeployed`        | If set to true, User Portal links will be available within *Graph UI*       | `true`                     |
| `configuration.graphUiDeployed`             | If set to true, *Graph UI* links will be available within *Graph UI*        | `true`                     |
| `configuration.searchUiDeployed`            | If set to true, *Search UI* links will be available within *Graph UI*       | `true`                     |
| `configuration.dataCatalogUiDeployed`       | If set to true, *Data Catalog UI* links will be available within *Graph UI* | `true`                     |
| `configuration.graphUiMaptilerToken`        | is the MapTiler token for the *Graph UI*                                    | `your.maptiler.token.here` |
| `configuration.graphUiMapboxStyleSpecUrl`   |                                                                             | `""`                       |
| `configuration.graphUiArcgisToken`          |                                                                             | `""`                       |
| `configuration.existingMapConfigSecretName` | The name of an existing secret containing map configuration                 | `""`                       |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                                                | Description                                                               | Value                            |
| --------------------------------------------------- | ------------------------------------------------------------------------- | -------------------------------- |
| `replicas`                                          | Number of *Graph UI* replicas to deploy                                   | `1`                              |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                    | `5`                              |
| `annotations`                                       | Add extra annotations to the deployment object                            | `{}`                             |
| `podLabels`                                         | Add extra labels to the *Graph UI* pod                                    | `{}`                             |
| `podAnnotations`                                    | Add extra annotations to the *Graph UI* pod                               | `{}`                             |
| `extraEnvVars`                                      | Array with extra environment variables to add to *Graph UI* pod           | `[]`                             |
| `extraVolumes`                                      | Additional containers to be added to the *Graph UI* pod                   | `[]`                             |
| `extraVolumeMounts`                                 | Optionally specify extra list of additional volumeMounts                  | `[]`                             |
| `initContainers`                                    | Add init containers to the pod                                            | `[]`                             |
| `sidecars`                                          | Add sidecars to the pod.                                                  | `[]`                             |
| `image.registry`                                    | *Graph UI* image registry                                                 | `REGISTRY_NAME`                  |
| `image.repository`                                  | *Graph UI* image name                                                     | `REPOSITORY_NAME/telicent-graph` |
| `image.tag`                                         | Seearch UI image tag. If not set, a tag is generated using the appVersion | `""`                             |
| `image.pullPolicy`                                  | *Graph UI* image pull policy                                              | `IfNotPresent`                   |
| `image.pullSecrets`                                 | Specify registry secret names as an array                                 | `[]`                             |
| `resources.requests.cpu`                            | Set containers' CPU request                                               | `250m`                           |
| `resources.requests.memory`                         | Set containers' memory request                                            | `512Mi`                          |
| `resources.limits.cpu`                              | Set containers' CPU limit                                                 | `375m`                           |
| `resources.limits.memory`                           | Set containers' memory limit                                              | `768Mi`                          |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                        | `185`                            |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                      | `185`                            |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                             | `true`                           |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                 | `false`                          |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                        | `["ALL"]`                        |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                          | `RuntimeDefault`                 |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID             | `185`                            |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID           | `185`                            |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                  | `true`                           |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem   | `185`                            |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile               | `RuntimeDefault`                 |
| `affinity`                                          | Affinity for pod assignment                                               | `{}`                             |
| `nodeSelector`                                      | Node labels for pod assignment                                            | `{}`                             |
| `tolerations`                                       | Tolerations for pod assignment                                            | `[]`                             |

### Service Account Parameters

| Name                         | Description                                                                           | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                 | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                | `true` |

### Traffic Exposure Parameters

| Name           | Description                                                                 | Value       |
| -------------- | --------------------------------------------------------------------------- | ----------- |
| `service.name` | *Graph UI* service name. If not set, a name is generated using the fullname | `""`        |
| `service.port` | *Graph UI* service port                                                     | `8080`      |
| `service.type` | *Graph UI* service type                                                     | `ClusterIP` |

### Istio Parameters

| Name                               | Description                                                                                                                                              | Value           |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| `istio.ingress.principal`          | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using Release namespace and serviceAccountName | `""`            |
| `istio.ingress.serviceAccountName` | Name of the Ingress service account (traefik and istio supported)                                                                                        | `traefik-proxy` |

## License

Copyright &copy; 2025 Telicent Limited