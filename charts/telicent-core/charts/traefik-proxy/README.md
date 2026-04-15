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

Contains global parameters; these parameters are mirrored within the Telicent core umbrella chart.
Note: Only global parameters used within this chart will be listed below.

| Name                                | Description                                                                                                                                                                            | Value             |
| ----------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| `global.releaseNameTelicentPreview` | Release name used during the Telicent Preview chart installation. Note: ensure the value is correct, otherwise there will be no access to data-catalog, user-portal & paperback-writer | `""`              |
| `global.enterprise`                 | Enable enterprise mode, adding additional features and configurations                                                                                                                  | `false`           |
| `global.appHostDomain`              | Domain associated with Telicent application/ui services. This value cannot be changed after it is set                                                                                  | `""`              |
| `global.apiHostDomain`              | Domain associated with Telicent Api services. This value cannot be changed after it is set                                                                                             | `""`              |
| `global.authHostDomain`             | Domain associated with Telicent authentication services, including OIDC providers. This value cannot be changed after it is set                                                        | `""`              |
| `global.istioIngressNamespace`      | Namespace in which the Istio Ingress resource is deployed; overrides 'istio.ingress.namespace'                                                                                         | `istio-system`    |
| `global.istioIngressServiceAccount` | ServiceAccount associated with Istio ingress deployment; overrides 'istio.ingress.serviceAccount'                                                                                      | `istio-ingress`   |
| `global.istioGatewayNamespace`      | Namespace in which the Istio Gateway resource is deployed; overrides 'istio.gateway.namespace'                                                                                         | `istio-system`    |
| `global.istioGatewayName`           | Name of the Istio Gateway resource; overrides 'istio.gateway.namespace'                                                                                                                | `ingress-gateway` |

### Application Parameters - Rate Limit

The following section allows for setting Traefik Rate Limiting on the Web Applications, API Services and the Authentication Service.
Ref: https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/ratelimit/#rate-and-burst

| Name                     | Description                                                                                             | Value |
| ------------------------ | ------------------------------------------------------------------------------------------------------- | ----- |
| `rateLimit.app.average`  | Maximum number of requests per second allowed to the Web Applications (0 means no rate limiting).       | `0`   |
| `rateLimit.app.burst`    | Maximum number of requests allowed to go through at the very same moment to the Web Applications.       | `100` |
| `rateLimit.api.average`  | Maximum number of requests per second allowed to the API Services (0 means no rate limiting).           | `100` |
| `rateLimit.api.burst`    | Maximum number of requests allowed to go through at the very same moment to the API Services.           | `25`  |
| `rateLimit.auth.average` | Maximum number of requests per second allowed to the Authentication Service (0 means no rate limiting). | `10`  |
| `rateLimit.auth.burst`   | Maximum number of requests allowed to go through at the very same moment to the Authentication Service. | `5`   |

### Application Parameters - CORS

| Name              | Description                                           | Value |
| ----------------- | ----------------------------------------------------- | ----- |
| `cors.extraHosts` | Additional hosts to be added to the 'AllowOriginList' | `[]`  |

### Application Parameters - ForwardAuth and Secret

When making requests to the *Auth* Application endpoint `/auth/forward`, `X-ForwardAuth-Secret` header is required.
The secret associated with that header is defined within this section.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-gen-forward-traefik-proxy` will be created if one is not set.

| Name                         | Description                                                         | Value |
| ---------------------------- | ------------------------------------------------------------------- | ----- |
| `forwardAuth.existingSecret` | Name of an existing secret. The secret must contain 1 key: 'secret' | `""`  |
| `forwardAuth.header`         | The secret value to be associated with the `X-ForwardAuth-Secret`.  | `""`  |

### Application Parameters - Logs

| Name                  | Description                                                                        | Value   |
| --------------------- | ---------------------------------------------------------------------------------- | ------- |
| `logs.general.level`  | Set logging levels, values are: TRACE, DEBUG, INFO, WARN, ERROR, FATAL, and PANIC. | `INFO`  |
| `logs.access.enabled` | Enable access logging. Note: should only be enabled in development environments.   | `false` |

### Application Parameters - Dashboard

| Name                 | Description                                                                                 | Value       |
| -------------------- | ------------------------------------------------------------------------------------------- | ----------- |
| `dashboard.enabled`  | Enable *Traefik Proxy* dashboard. Note: should only be enabled in development environments. | `false`     |
| `dashboard.domain`   | Domain associated with *Traefik Proxy* dashboard. If not set, 'appHostDomain' will be used  | `""`        |
| `dashboard.basepath` | Set the base path to be used for accessing the dashboard                                    | `/traefik/` |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                   | Description                                                          | Value |
| ---------------------- | -------------------------------------------------------------------- | ----- |
| `replicas`             | Number of *Traefik Proxy* replicas to deploy                         | `1`   |
| `revisionHistoryLimit` | Number of controller revisions to keep                               | `5`   |
| `annotations`          | Add extra annotations to the deployment object                       | `{}`  |
| `podLabels`            | Add extra labels to the *Traefik Proxy* pod                          | `{}`  |
| `podAnnotations`       | Add extra annotations to the *Traefik Proxy* pod                     | `{}`  |
| `extraEnvVars`         | Array with extra environment variables to add to *Traefik Proxy* pod | `[]`  |
| `extraVolumes`         | Optionally specify extra list of additional volumes                  | `[]`  |
| `extraVolumeMounts`    | Optionally specify extra list of additional volumeMounts             | `[]`  |
| `initContainers`       | Add init containers to the pod                                       | `[]`  |
| `sidecars`             | Add sidecars to the pod                                              | `[]`  |

### Deployment Image Parameters

| Name                | Description                                                                    | Value          |
| ------------------- | ------------------------------------------------------------------------------ | -------------- |
| `image.registry`    | *Traefik Proxy* image registry                                                 | `docker.io`    |
| `image.repository`  | *Traefik Proxy* image name                                                     | `traefik`      |
| `image.tag`         | *Traefik Proxy* image tag. If not set, a tag is generated using the appVersion | `""`           |
| `image.pullPolicy`  | *Traefik Proxy* image pull policy                                              | `IfNotPresent` |
| `image.pullSecrets` | Specify registry secret names as an array                                      | `[]`           |

### Deployment Resources Parameters - Requests and Limits

| Name        | Description                              | Value |
| ----------- | ---------------------------------------- | ----- |
| `resources` | Resources for *Traefik Proxy* containers | `{}`  |

### Statefulset Security Context Parameters - Default Security Context

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

| Name                | Description                                                                      | Value       |
| ------------------- | -------------------------------------------------------------------------------- | ----------- |
| `service.name`      | *Traefik Proxy* service name. If not set, a name is generated using the fullname | `""`        |
| `service.app.port`  | *Traefik Proxy* APP/UI service port                                              | `8080`      |
| `service.app.type`  | *Traefik Proxy* APP/UI service type                                              | `ClusterIP` |
| `service.api.port`  | *Traefik Proxy* API service port                                                 | `8081`      |
| `service.api.type`  | *Traefik Proxy* API service type                                                 | `ClusterIP` |
| `service.auth.port` | *Traefik Proxy* AUTH service port                                                | `8082`      |
| `service.auth.type` | *Traefik Proxy* AUTH service type                                                | `ClusterIP` |

### Istio Parameters

| Name                              | Description                                                                 | Value             |
| --------------------------------- | --------------------------------------------------------------------------- | ----------------- |
| `istio.ingress.namespace`         | Namespace in which the Istio Ingress resource is deployed                   | `istio-system`    |
| `istio.ingress.serviceAccount`    | ServiceAccount associated with Istio ingress deployment                     | `istio-ingress`   |
| `istio.gateway.namespace`         | Namespace in which the Istio Gateway resource is deployed                   | `istio-system`    |
| `istio.gateway.name`              | Name of the Istio Gateway resource                                          | `ingress-gateway` |
| `istio.virtualService.enabled`    | Enable Istio traffic into *Traefik Proxy*                                   | `true`            |
| `istio.virtualService.extraHosts` | Additional hosts (excluding appHostDomain) to be managed by *Traefik Proxy* | `[]`              |

### Host(s) Parameters - Contains host information for applications deployed via *telicent-core* chart

*Traefik Proxy* routes traffic to Telicent Applications using their default service/serviceAccount and port.
If either of those details changes, you can use this section to correctly refer to those applications.

| Name                      | Description                                                                                                                                                                                                                        | Value                   |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| `hosts.enableAutoCorrect` | Allow for the release name to be automatically pre-fixed to each host value when required (default behavior when installing through the parent chart). Alternatively, the host value will be used as is, without any modification. | `true`                  |
| `hosts.auth`              | Auth application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                                   | `auth:8080`             |
| `hosts.userPreferences`   | User Preferences host value, If not set a host is generated using service:'user-preferences',port:'8080' and Release namespace & name.                                                                                             | `user-preferences:8080` |
| `hosts.adminUi`           | Admin UI application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                               | `admin-ui:8080`         |
| `hosts.searchUi`          | Search UI application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                              | `search-ui:8080`        |
| `hosts.graphUi`           | Graph UI application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                               | `graph-ui:8080`         |
| `hosts.queryUi`           | Query UI application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                               | `query-ui:8080`         |
| `hosts.search`            | Search application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                                 | `search:8080`           |
| `hosts.graph`             | Graph application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                                  | `graph:8080`            |

### Host(s) Preview Parameters - Contains host information for applications deployed via *telicent-preview* chart

*Traefik Proxy* interacts with applications deployed via *telicent-preview* using their default service/serviceAccount and port.
If either of those details changes, you can use this section to correctly refer to those applications.

| Name                             | Description                                                                                                                                        | Value                    |
| -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `hostsPreview.enableAutoCorrect` | Prefix 'global.releaseNameTelicentPreview' value to each host value. Alternatively, the host value will be used as it is, without any modification | `true`                   |
| `hostsPreview.dataCatalogUi`     | Data Catalog UI application default host value, as defined by 'service/serviceAccount:port'                                                        | `data-catalog-ui:8080`   |
| `hostsPreview.userPortalUi`      | User Portal UI application default host value, as defined by 'service/serviceAccount:port'                                                         | `user-portal-ui:8080`    |
| `hostsPreview.paperbackWriter`   | Paperback Writer application host value, as defined by 'service/serviceAccount:port'                                                               | `paperback-writer:8080`  |
| `hostsPreview.aiSparqlBuilder`   | AI SPARQL Builder application host value, as defined by 'service/serviceAccount:port'                                                              | `ai-sparql-builder:8080` |
| `hostsPreview.notifications`     | Notifications application default host value, as defined by 'service/serviceAccount:port'                                                          | `notifications:8080`     |
| `hostsPreview.apicurio`          | Apicurio Registry application default host value, as defined by 'service/serviceAccount:port'                                                      | `apicurio:8080`          |

## License

Copyright &copy; 2026 Telicent Limited