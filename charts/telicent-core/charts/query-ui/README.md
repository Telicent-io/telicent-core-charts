# Telicent Package for Query UI

Telicent Query UI is a starter application for querying data in Telicent CORE.

## Introduction

This chart bootstraps Telicent Query UI deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/query-ui
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
 --values=charts/telicent-core/charts/query-ui/values.yaml \
 --readme=charts/telicent-core/charts/query-ui/README.md \
 --schema=charts/telicent-core/charts/query-ui/values.schema.json
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

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                                                | Description                                                             | Value                            |
| --------------------------------------------------- | ----------------------------------------------------------------------- | -------------------------------- |
| `replicas`                                          | Number of *Query UI* replicas to deploy                                 | `1`                              |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                  | `5`                              |
| `annotations`                                       | Add extra annotations to the deployment object                          | `{}`                             |
| `podLabels`                                         | Add extra labels to the *Search UI* pod                                 | `{}`                             |
| `podAnnotations`                                    | Add extra annotations to the *Search UI* pod                            | `{}`                             |
| `extraEnvVars`                                      | Array with extra environment variables to add to *Search UI* pod        | `[]`                             |
| `extraVolumes`                                      | Additional containers to be added to the *Search UI* pod                | `[]`                             |
| `extraVolumeMounts`                                 | Optionally specify extra list of additional volumeMounts                | `[]`                             |
| `initContainers`                                    | Add init containers to the pod                                          | `[]`                             |
| `sidecars`                                          | Add sidecars to the pod.                                                | `[]`                             |
| `image.registry`                                    | *Query UI* image registry                                               | `REGISTRY_NAME`                  |
| `image.repository`                                  | *Query UI* image name                                                   | `REPOSITORY_NAME/telicent-query` |
| `image.tag`                                         | Query UI image tag. If not set, a tag is generated using the appVersion | `""`                             |
| `image.pullPolicy`                                  | *Query UI* image pull policy                                            | `IfNotPresent`                   |
| `image.pullSecrets`                                 | Specify registry secret names as an array                               | `[]`                             |
| `resources.requests.cpu`                            | Set containers' CPU request                                             | `125m`                           |
| `resources.requests.memory`                         | Set containers' memory request                                          | `512Mi`                          |
| `resources.limits.cpu`                              | Set containers' CPU limit                                               | `250m`                           |
| `resources.limits.memory`                           | Set containers' memory limit                                            | `768Mi`                          |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                      | `185`                            |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                    | `185`                            |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                           | `true`                           |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation               | `false`                          |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                      | `["ALL"]`                        |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                        | `RuntimeDefault`                 |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID           | `185`                            |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID         | `185`                            |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                | `true`                           |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem | `185`                            |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile             | `RuntimeDefault`                 |
| `affinity`                                          | Affinity for pod assignment                                             | `{}`                             |
| `nodeSelector`                                      | Node labels for pod assignment                                          | `{}`                             |
| `tolerations`                                       | Tolerations for pod assignment                                          | `[]`                             |

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
| `service.name` | *Query UI* service name. If not set, a name is generated using the fullname | `""`        |
| `service.port` | *Query UI* service port                                                     | `8080`      |
| `service.type` | *Query UI* service type                                                     | `ClusterIP` |

### Istio Parameters

| Name                               | Description                                                                                                                                              | Value           |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| `istio.ingress.principal`          | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using Release namespace and serviceAccountName | `""`            |
| `istio.ingress.serviceAccountName` | Name of the Ingress service account (traefik and istio supported)                                                                                        | `traefik-proxy` |


## License

Copyright &copy; 2025 Telicent Limited
