# Telicent Package for Data Catalog

Telicent Data Catalog UI provides metadata management and data discovery capabilities within Telicent CORE, allowing users to catalog, search, and manage data assets across the platform.

## Introduction

This chart bootstraps Telicent Data Catalog UI deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/data-catalog-ui
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
 --values=charts/telicent-core/charts/data-catalog-ui/values.yaml \
 --readme=charts/telicent-core/charts/data-catalog-ui/README.md \
 --schema=charts/telicent-core/charts/data-catalog-ui/values.schema.json
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

Contains global parameters; these parameters are mirrored within the Telicent core umbrella chart
Note: Only global parameters used within this chart will be listed below

| Name                      | Description                                                                       | Value              |
| ------------------------- | --------------------------------------------------------------------------------- | ------------------ |
| `global.imageRegistry`    | Global image registry                                                             | `""`               |
| `global.imagePullSecrets` | Global registry secret names as an array                                          | `[]`               |
| `global.appHostDomain`    | Domain associated with Telicent application/ui services                           | `apps.telicent.io` |
| `global.apiHostDomain`    | Domain associated with Telicent Api services                                      | `api.telicent.io`  |
| `global.authHostDomain`   | Domain associated with Telicent authentication services, including OIDC providers | `auth.telicent.io` |

### ConfigMap Parameters

| Name                          | Description                                                  | Value |
| ----------------------------- | ------------------------------------------------------------ | ----- |
| `configMap.existingConfigMap` | The name of an existing config map containing env-config.js. | `""`  |

### OAuth Parameters

| Name             | Description                                          | Value                           |
| ---------------- | ---------------------------------------------------- | ------------------------------- |
| `oauth.clientId` | The OAuth client id to be used by *Data Catalog UI*  | `telicent-catalog-ui`           |
| `oauth.scopes`   | List of OAuth scopes to be used by *Data Catalog UI* | `openid profile offline_access` |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                                                | Description                                                                      | Value                            |
| --------------------------------------------------- | -------------------------------------------------------------------------------- | -------------------------------- |
| `replicas`                                          | Number of *Data Catalog UI* replicas to deploy                                   | `1`                              |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                           | `5`                              |
| `annotations`                                       | Add extra annotations to the deployment object                                   | `{}`                             |
| `podLabels`                                         | Add extra labels to the *Data Catalog UI* pod                                    | `{}`                             |
| `podAnnotations`                                    | Add extra annotations to the *Data Catalog UI* pod                               | `{}`                             |
| `extraEnvVars`                                      | Array with extra environment variables to add to *Data Catalog UI* pod           | `[]`                             |
| `extraVolumes`                                      | Additional containers to be added to the *Data Catalog UI* pod                   | `[]`                             |
| `extraVolumeMounts`                                 | Optionally specify extra list of additional volumeMounts                         | `[]`                             |
| `initContainers`                                    | Add init containers to the pod                                                   | `[]`                             |
| `sidecars`                                          | Add sidecars to the pod.                                                         | `[]`                             |
| `image.registry`                                    | *Data Catalog UI* image registry                                                 | `quay.io`                        |
| `image.repository`                                  | *Data Catalog UI* image name                                                     | `telicent/telicent-data-catalog` |
| `image.tag`                                         | *Data Catalog UI* image tag. If not set, a tag is generated using the appVersion | `""`                             |
| `image.pullPolicy`                                  | *Data Catalog UI* image pull policy                                              | `IfNotPresent`                   |
| `image.pullSecrets`                                 | Specify registry secret names as an array                                        | `[]`                             |
| `resources.requests.cpu`                            | Set containers' CPU request                                                      | `250m`                           |
| `resources.requests.memory`                         | Set containers' memory request                                                   | `500Mi`                          |
| `resources.limits.cpu`                              | Set containers' CPU limit                                                        | `500m`                           |
| `resources.limits.memory`                           | Set containers' memory limit                                                     | `1000Mi`                         |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                               | `185`                            |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                             | `185`                            |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                                    | `true`                           |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                        | `false`                          |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                               | `["ALL"]`                        |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                                 | `RuntimeDefault`                 |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID                    | `185`                            |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID                  | `185`                            |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                         | `true`                           |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem          | `185`                            |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile                      | `RuntimeDefault`                 |
| `affinity`                                          | Affinity for pod assignment                                                      | `{}`                             |
| `nodeSelector`                                      | Node labels for pod assignment                                                   | `{}`                             |
| `tolerations`                                       | Tolerations for pod assignment                                                   | `[]`                             |

### Service Account Parameters

| Name                         | Description                                                                           | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                 | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                | `true` |

### Traffic Exposure Parameters

| Name           | Description                                                                        | Value       |
| -------------- | ---------------------------------------------------------------------------------- | ----------- |
| `service.name` | *Data Catalog UI* service name. If not set, a name is generated using the fullname | `""`        |
| `service.port` | *Data Catalog UI* service port                                                     | `8080`      |
| `service.type` | *Data Catalog UI* service type                                                     | `ClusterIP` |

### Host(s) Core Parameters - Contains host information for applications deployed via *telicent-core* chart

*Data Catalog UI* interacts with applications deployed via *telicent-core* using their default service/serviceAccount and port.
If either of those details changes, you can use this section to correctly referer to those applications.

| Name                          | Description                                                                                                                             | Value                |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | -------------------- |
| `hostsCore.enableAutoCorrect` | Prefix 'global.releaseNameTelicentCore' to each host value. Alternatively, the host value will be used as is, without any modification. | `true`               |
| `hostsCore.traefikProxy`      | Traefik Proxy application default host value, as defined by 'service/serviceAccount:port'                                               | `traefik-proxy:8080` |
| `hostsCore.auth`              | Auth application default host value, as defined by 'service/serviceAccount:port'                                                        | `auth:8080`          |


## License

Copyright &copy; 2025 Telicent Limited