# Telicent Package for Search UI

Telicent Search UI is an application for searching data in Telicent CORE.

## Introduction

This chart bootstraps Telicent Search UI deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

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

### Resource requests and limits

These are inside the `resources` value (check parameter table). Setting requests is essential for production workloads
and these should be adapted to your specific use case.

### Sidecars and Init Containers

If you have a need for additional containers to run within the same pod (e.g. an additional metrics or logging
exporter), you can do so via the `sidecars` config parameter.
Define your container according to the Kubernetes container spec.

```yaml
sidecars:
- name: your-image-name
  image: your-image
  imagePullPolicy: Always
  ports:
  - name: portname
    containerPort: 1234
```

Similarly, you can add extra init containers using the `initContainers` parameter.

```yaml
initContainers:
- name: your-image-name
  image: your-image
  imagePullPolicy: Always
  ports:
  - name: portname
    containerPort: 1234
```

### Setting Pod's affinity

This chart allows you to set your custom affinity using the `affinity` parameter.
Find more information about Pod's affinity in
the [kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity).


## Parameters

### Global Parameters

Contains global parameters; these parameters are mirrored within the Telicent core umbrella chart.
Note: Only global parameters used within this chart will be listed below.

| Name                      | Description                                                                                                                     | Value   |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `global.imageRegistry`    | Global image registry                                                                                                           | `""`    |
| `global.imagePullSecrets` | Global registry secret names as an array                                                                                        | `[]`    |
| `global.enterprise`       | Enable enterprise mode, adding additional features and configurations                                                           | `false` |
| `global.appHostDomain`    | Domain associated with Telicent application/ui services. This value cannot be changed after it is set                           | `""`    |
| `global.apiHostDomain`    | Domain associated with Telicent Api services. This value cannot be changed after it is set                                      | `""`    |
| `global.authHostDomain`   | Domain associated with Telicent authentication services, including OIDC providers. This value cannot be changed after it is set | `""`    |

### Application Parameters - UI and Secret

Contains parameters specific to the Search User Interface.
Map functionality requires tokens and configuration defined within a secret.
It is recommended to store sensitive information including tokens/passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-gen-mapjs-search-ui` will be created if one is not set.

| Name                         | Description                                                                                                        | Value                      |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------ | -------------------------- |
| `ui.graphUiDeployed`         | If set to true, *Graph UI* links will be available within *Search UI*                                              | `true`                     |
| `ui.userPortalUiDeployed`    | If set to true, *User Portal UI* links will be available within *Search UI*                                        | `true`                     |
| `ui.dataCatalogUiDeployed`   | If set to true, *Data Catalog UI* links will be available within *Search UI*                                       | `true`                     |
| `ui.maptilerToken`           | MapTiler token for *Search UI*                                                                                     | `your.maptiler.token.here` |
| `ui.mapboxStyleSpecUrl`      | Mapbox style spec URL for *Search UI*                                                                              | `""`                       |
| `ui.arcgisToken`             | ArcGIS token for *Search UI*                                                                                       | `""`                       |
| `ui.existingMapConfigSecret` | The name of an existing secret containing map configuration. See: '_mapjs.tpl' & 'secret-mapjs.yaml'               | `""`                       |
| `ui.mapV2Enabled`            | Whether to enable the new map implementation. MapV2 will eventually become the default and only map implementation | `false`                    |

### Application Parameters - OAuth

| Name             | Description                                    | Value                           |
| ---------------- | ---------------------------------------------- | ------------------------------- |
| `oauth.clientId` | The OAuth client id to be used by *Search UI*  | `telicent-search-ui`            |
| `oauth.scopes`   | List of OAuth scopes to be used by *Search UI* | `openid profile offline_access` |

### ConfigMap Parameters

| Name                          | Description                                                  | Value |
| ----------------------------- | ------------------------------------------------------------ | ----- |
| `configMap.existingConfigMap` | The name of an existing config map containing env-config.js. | `""`  |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                   | Description                                                      | Value |
| ---------------------- | ---------------------------------------------------------------- | ----- |
| `replicas`             | Number of *Search UI* replicas to deploy                         | `1`   |
| `revisionHistoryLimit` | Number of controller revisions to keep                           | `5`   |
| `annotations`          | Add extra annotations to the deployment object                   | `{}`  |
| `podLabels`            | Add extra labels to the *Search UI* pod                          | `{}`  |
| `podAnnotations`       | Add extra annotations to the *Search UI* pod                     | `{}`  |
| `extraEnvVars`         | Array with extra environment variables to add to *Search UI* pod | `[]`  |
| `extraVolumes`         | Optionally specify extra list of additional volumes              | `[]`  |
| `extraVolumeMounts`    | Optionally specify extra list of additional volumeMounts         | `[]`  |
| `initContainers`       | Add init containers to the pod                                   | `[]`  |
| `sidecars`             | Add sidecars to the pod                                          | `[]`  |

### Deployment Image Parameters

| Name                | Description                                                                | Value                      |
| ------------------- | -------------------------------------------------------------------------- | -------------------------- |
| `image.registry`    | *Search UI* image registry                                                 | `quay.io`                  |
| `image.repository`  | *Search UI* image name                                                     | `telicent/telicent-search` |
| `image.tag`         | *Search UI* image tag. If not set, a tag is generated using the appVersion | `""`                       |
| `image.pullPolicy`  | *Search UI* image pull policy                                              | `IfNotPresent`             |
| `image.pullSecrets` | Specify registry secret names as an array                                  | `[]`                       |

### Deployment Resources Parameters - Requests and Limits

| Name        | Description                          | Value |
| ----------- | ------------------------------------ | ----- |
| `resources` | Resources for *Search UI* containers | `{}`  |

### Deployment Security Context Parameters - Default Security Context

| Name                                                | Description                                                             | Value            |
| --------------------------------------------------- | ----------------------------------------------------------------------- | ---------------- |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID           | `185`            |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID         | `185`            |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                | `true`           |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem | `185`            |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile             | `RuntimeDefault` |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                      | `185`            |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                    | `185`            |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                           | `true`           |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation               | `false`          |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                      | `["ALL"]`        |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                        | `RuntimeDefault` |

### Deployment Affinity Parameters

| Name           | Description                    | Value |
| -------------- | ------------------------------ | ----- |
| `affinity`     | Affinity for pod assignment    | `{}`  |
| `nodeSelector` | Node labels for pod assignment | `{}`  |
| `tolerations`  | Tolerations for pod assignment | `[]`  |

### Service Account Parameters

| Name                         | Description                                                                           | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                 | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                | `true` |

### Traffic Exposure Parameters

| Name           | Description                                                                  | Value       |
| -------------- | ---------------------------------------------------------------------------- | ----------- |
| `service.name` | *Search UI* service name. If not set, a name is generated using the fullname | `""`        |
| `service.port` | *Search UI* service port                                                     | `8080`      |
| `service.type` | *Search UI* service type                                                     | `ClusterIP` |

### Host(s) Parameters - Contains host information for applications deployed via *telicent-core* chart.

*Search UI* interacts directly with other Telicent Applications using their default service/serviceAccount and port.
If either of those details changes, you can use this section to correctly refer to those applications.

| Name                      | Description                                                                                                                                                                                                                          | Value                |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------- |
| `hosts.enableAutoCorrect` | Allow for the release name to be automatically pre-fixed to each host value when required (default behavior when installing through the parent chart). Alternatively, the host value will be used as it is, without any modification | `true`               |
| `hosts.traefikProxy`      | Traefik Proxy application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                            | `traefik-proxy:8080` |


## License

Copyright &copy; 2025 Telicent Limited