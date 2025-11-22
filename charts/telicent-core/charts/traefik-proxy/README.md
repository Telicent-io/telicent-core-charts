# Telicent Package for Traefik

[Traefik](https://github.com/traefik/traefik) is an open source reverse proxy and ingress controller that makes
deploying services and APIs easy.

## Introduction

This chart bootstraps Traefik deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/traefik-proxy
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
 --values=charts/telicent-core/charts/traefik-proxy/values.yaml \
 --readme=charts/telicent-core/charts/traefik-proxy/README.md \
 --schema=charts/telicent-core/charts/traefik-proxy/values.schema.json
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

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                                | Description                                                                       | Value              |
| ----------------------------------- | --------------------------------------------------------------------------------- | ------------------ |
| `global.imageRegistry`              | Global image registry                                                             | `""`               |
| `global.imagePullSecrets`           | Global registry secret names as an array                                          | `[]`               |
| `global.enterprise`                 | Enable enterprise mode, adding additional features and configurations             | `false`            |
| `global.appHostDomain`              | Domain associated with Telicent application/ui services                           | `apps.telicent.io` |
| `global.apiHostDomain`              | Domain associated with Telicent Api services                                      | `api.telicent.io`  |
| `global.authHostDomain`             | Domain associated with Telicent authentication services, including OIDC providers | `auth.telicent.io` |
| `global.groupsClaim`                | Key used to retrieve groups from the OIDC provider                                | `groups`           |
| `global.istioNamespace`             | Namespace in which Istio is deployed                                              | `istio-system`     |
| `global.istioServiceAccountName`    | Name of the Istio service account                                                 | `istio-ingress`    |
| `global.istioGatewayName`           | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)         | `ingress-gateway`  |
| `global.istioVirtualServiceEnabled` | Enable Istio traffic routing to a named destination service                       | `true`             |

### ForwardAuth Parameters and Secret

When making requests to the *Auth* Application endpoint `/auth/forward`, `X-ForwardAuth-Secret` header is required.
The secret associated with that header is defined within this section.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-gen-forward-traefik-proxy` will be created if one is not set.

| Name                         | Description                                                         | Value |
| ---------------------------- | ------------------------------------------------------------------- | ----- |
| `forwardAuth.existingSecret` | Name of an existing secret. The secret must contain 1 key: 'secret' | `""`  |
| `forwardAuth.header`         | The secret value to be associated with the `X-ForwardAuth-Secret`.  | `""`  |

### *Traefik Proxy* Logs Parameters

| Name                  | Description                                                                        | Value   |
| --------------------- | ---------------------------------------------------------------------------------- | ------- |
| `logs.general.level`  | Set logging levels, values are: TRACE, DEBUG, INFO, WARN, ERROR, FATAL, and PANIC. | `INFO`  |
| `logs.access.enabled` | Enable access logging. Note: should only be enabled in development environments.   | `false` |

### *Traefik Proxy* Dashboard Parameters

| Name                 | Description                                                                                 | Value      |
| -------------------- | ------------------------------------------------------------------------------------------- | ---------- |
| `dashboard.enabled`  | Enable *Traefik Proxy* dashboard. Note: should only be enabled in development environments. | `false`    |
| `dashboard.domain`   | Domain associated with *Traefik Proxy* dashboard. If not set, 'appHostDomain' will be used  | `""`       |
| `dashboard.basepath` | Set the base path to be used for accessing the dashboard                                    | `/traefik` |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                                                | Description                                                                    | Value                     |
| --------------------------------------------------- | ------------------------------------------------------------------------------ | ------------------------- |
| `replicas`                                          | Number of *Traefik Proxy* replicas to deploy                                   | `1`                       |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                         | `5`                       |
| `annotations`                                       | Add extra annotations to the deployment object                                 | `{}`                      |
| `podLabels`                                         | Add extra labels to the *Traefik Proxy* pod                                    | `{}`                      |
| `podAnnotations`                                    | Add extra annotations to the *Traefik Proxy* pod                               | `{}`                      |
| `extraEnvVars`                                      | Array with extra environment variables to add to *Traefik Proxy* pod           | `[]`                      |
| `extraVolumes`                                      | Additional containers to be added to the *Traefik Proxy* pod                   | `[]`                      |
| `extraVolumeMounts`                                 | Optionally specify extra list of additional volumeMounts                       | `[]`                      |
| `initContainers`                                    | Add init containers to the pod                                                 | `[]`                      |
| `sidecars`                                          | Add sidecars to the pod.                                                       | `[]`                      |
| `image.registry`                                    | *Traefik Proxy* image registry                                                 | `REGISTRY_NAME`           |
| `image.repository`                                  | *Traefik Proxy* image name                                                     | `REPOSITORY_NAME/traefik` |
| `image.tag`                                         | *Traefik Proxy* image tag. If not set, a tag is generated using the appVersion | `""`                      |
| `image.pullPolicy`                                  | *Traefik Proxy* image pull policy                                              | `IfNotPresent`            |
| `image.pullSecrets`                                 | Specify registry secret names as an array                                      | `[]`                      |
| `resources.requests.cpu`                            | Set containers' CPU request                                                    | `125m`                    |
| `resources.requests.memory`                         | Set containers' memory request                                                 | `512Mi`                   |
| `resources.limits.cpu`                              | Set containers' CPU limit                                                      | `250m`                    |
| `resources.limits.memory`                           | Set containers' memory limit                                                   | `768Mi`                   |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                             | `185`                     |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                           | `185`                     |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                                  | `true`                    |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                      | `false`                   |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                             | `["ALL"]`                 |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                               | `RuntimeDefault`          |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID                  | `185`                     |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID                | `185`                     |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                       | `true`                    |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem        | `185`                     |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile                    | `RuntimeDefault`          |
| `affinity`                                          | Affinity for pod assignment                                                    | `{}`                      |
| `nodeSelector`                                      | Node labels for pod assignment                                                 | `{}`                      |
| `tolerations`                                       | Tolerations for pod assignment                                                 | `[]`                      |

### Service Account Parameters

| Name                         | Description                                                                           | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                 | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                | `true` |

### Traffic Exposure Parameters

| Name               | Description                         | Value       |
| ------------------ | ----------------------------------- | ----------- |
| `service.app.port` | *Traefik Proxy* APP/UI service port | `8080`      |
| `service.app.type` | *Traefik Proxy* APP/UI service type | `ClusterIP` |
| `service.api.port` | *Traefik Proxy* service port        | `8081`      |
| `service.api.type` | *Traefik Proxy* service type        | `ClusterIP` |

### Istio Parameters

| Name                               | Description                                                                                                                                              | Value                                            |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| `istio.virtualService.enabled`     | Enable Istio traffic into *Traefik Proxy*                                                                                                                | `true`                                           |
| `istio.virtualService.extraHosts`  | Additional hosts (excluding appHostDomain) to be managed by *Traefik Proxy*                                                                              | `[]`                                             |
| `istio.ingress.principal`          | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using Release namespace and serviceAccountName | `cluster.local/ns/istio-system/sa/istio-ingress` |
| `istio.ingress.serviceAccountName` | Name of the Ingress service account (istio currently supported)                                                                                          | `istio-ingress`                                  |

### *Traefik Proxy* Hosts Parameters

*Traefik Proxy* routes traffic to the various Telicent Apps using their default service names and ports.
If either of those details changes, you can use this section to correctly referer to those apps.
Example: overriding Search UI chart value `fullnameOverride: "search-ui"` the correct host value would be `searchUi: "search-ui:8080"`

| Name                    | Description                                                                                                                                                | Value |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `hosts.auth`            | Auth host value, If not set a host is generated using service:'auth',port:'8080' and Release namespace & name.                                             | `""`  |
| `hosts.access`          | Access host value, If not set a host is generated using service:'access',port:'8080' and Release namespace & name.                                         | `""`  |
| `hosts.adminUi`         | Admin UI host value, If not set a host is generated using service:'admin-ui',port:'8080' and Release namespace & name.                                     | `""`  |
| `hosts.accessUi`        | Access UI host value, If not set a host is generated using service:'access-ui',port:'8080' and Release namespace & name.                                   | `""`  |
| `hosts.dataCatalogUi`   | Data Catalog UI host value, If not set a host is generated using service:'data-catalog-ui',port:'8080' and Release namespace & name.                       | `""`  |
| `hosts.userPortalUi`    | User Portal UI host value, If not set a host is generated using service:'user-portal-ui',port:'8080' and Release namespace & name.                         | `""`  |
| `hosts.searchUi`        | Search UI host value, If not set a host is generated using service:'search-ui',port:'8080' and Release namespace & name.                                   | `""`  |
| `hosts.graphUi`         | Graph UI host value, If not set a host is generated using service:'graph-ui',port:'8080' and Release namespace & name.                                     | `""`  |
| `hosts.queryUi`         | Query UI host value, If not set a host is generated using service:'query-ui',port:'8080' and Release namespace & name.                                     | `""`  |
| `hosts.search`          | Search host value, If not set a host is generated using service:'search',port:'8080' and Release namespace & name.                                         | `""`  |
| `hosts.graph`           | Graph host value, If not set a host is generated using service:'graph',port:'8080' and Release namespace & name.                                           | `""`  |
| `hosts.userPreferences` | User Preferences host value, If not set a host is generated using service:'user-preferences',port:'8080' and Release namespace & name.                     | `""`  |
| `hosts.oauth2Proxy`     | Oauth2 Proxy host value, If not set a host is generated using service:'oauth2-proxy',port:'4080' and Release namespace & name.                             | `""`  |
| `hosts.whoami`          | Whoami host value, If not set a host is generated using service:'whoami',port:'8080' and Release namespace & name. AB:test purposes, be removed afterwards | `""`  |
| `hosts.paperbackWriter` | If not set a host is generated using service:'paperback-writer', port:'8000' and Release namespace & name.                                                 | `""`  |

## License

Copyright &copy; 2025 Telicent Limited