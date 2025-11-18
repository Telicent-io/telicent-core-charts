# Telicent Package for OAuth2 Proxy

Telicent OAuth2 Proxy provides authentication and authorization for applications by acting as a reverse proxy and
integrating with OAuth2 providers.

## Introduction

This chart bootstraps OAuth2 Proxy deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.
OAuth2 Proxy is a reverse proxy and static file server that provides authentication using providers such as Google,
GitHub, and OIDC.

For more information about OAuth2 Proxy, see the [official documentation](https://github.com/oauth2-proxy/oauth2-proxy).

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/oauth2-proxy
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
 --values=charts/telicent-core/charts/oauth2-proxy/values.yaml \
 --readme=charts/telicent-core/charts/oauth2-proxy/README.md \
 --schema=charts/telicent-core/charts/oauth2-proxy/values.schema.json
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
| `global.istioVirtualServiceEnabled` | Enable Istio traffic routing to a named destination service                       | `false`            |

### Configuration Parameters

Application Specific configuration for the *OAuth2 Proxy*.

| Name                                   | Description                                                                                     | Value                   |
| -------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------- |
| `configuration.existingEnvConfigMap`   | Name of existing configmap containing *Oauth2 Proxy* Environment Configuration                  | `""`                    |
| `configuration.oidcIssuerUrl`          | The OpenID Connect issuer URL                                                                   | `your.host/realms/core` |
| `configuration.redirectUrl`            | OIDC redirect URL override. If not set, 'authHostDomain' + '/oauth2/callback' will be used      | `""`                    |
| `configuration.cookieDomains`          | Domains that the cookie is valid for. If not set, 'appHostDomain' will be used                  | `""`                    |
| `configuration.cookieWhiteListDomains` | Allowed domains for redirection after authentication. If not set, 'apphHostDomain' will be used | `""`                    |
| `configuration.cookieExpire`           | Expire timeframe for cookie                                                                     | `50m`                   |
| `configuration.cookieCsrfExpire`       | Expire timeframe for CSRF cookie                                                                | `50m`                   |
| `configuration.cookieRefresh`          | Refresh the cookie after this duration                                                          | `30m`                   |

### Identity Provider (IDP) Parameters and Secret

Contains details pertinent to the OIDC Identity Provider to be used by *Oauth2 Proxy*.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-gen-idp-oauth2-proxy` will be created if one is not set.

| Name                 | Description                                                                                            | Value   |
| -------------------- | ------------------------------------------------------------------------------------------------------ | ------- |
| `idp.issuerUrl`      | The OpenID Connect issuer URL                                                                          | `""`    |
| `idp.jwksPath`       | The path to use in combination with the issuer URL for JWKS                                            | `/keys` |
| `idp.existingSecret` | Name of an existing secret. The secret must contain 3 keys: 'clientid', 'clientsecret', 'cookiesecret' | `""`    |
| `idp.clientId`       | The OAuth Client ID                                                                                    | `""`    |
| `idp.clientSecret`   | The OAuth Client Secret                                                                                | `""`    |
| `idp.cookieSecret`   | The seed string for secure cookies                                                                     | `""`    |

### TLS Parameters

| Name                       | Description                                                                                                                                 | Value |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `tls.ca.existingSecret`    | Name of an existing secret that contains CA certificate(s). The secret must contains 1 key: 'ca.crt' containing the CA certificate(s)       | `""`  |
| `tls.ca.existingConfigMap` | Name of an existing configmap that contains CA certificate(s). The configmap must contains 1 key: 'ca.crt' containing the CA certificate(s) | `""`  |
| `tls.ca.certificate`       | The PEM-encoded certificate(s) of the CA (certificate authority)                                                                            | `""`  |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                                                | Description                                                                   | Value                          |
| --------------------------------------------------- | ----------------------------------------------------------------------------- | ------------------------------ |
| `replicas`                                          | Number of *Ouath2 Proxy* replicas to deploy                                   | `1`                            |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                        | `5`                            |
| `annotations`                                       | Add extra annotations to the Deployment Object                                | `{}`                           |
| `podLabels`                                         | Add extra labels to the *Oauth2 Proxy* pod                                    | `{}`                           |
| `podAnnotations`                                    | Add extra annotations to the *Oauth2 Proxy* pod                               | `{}`                           |
| `extraEnvVars`                                      | Array with extra environment variables to add to *Oauth2 Proxy* pod           | `[]`                           |
| `extraVolumes`                                      | Additional containers to be added to the *Auth* pod                           | `[]`                           |
| `extraVolumeMounts`                                 | Optionally specify extra list of additional volumeMounts                      | `[]`                           |
| `initContainers`                                    | Add init containers to the pod                                                | `[]`                           |
| `sidecars`                                          | Add sidecars to the pod.                                                      | `[]`                           |
| `image.registry`                                    | *Oauth2 Proxy* image registry                                                 | `REGISTRY_NAME`                |
| `image.repository`                                  | *Oauth2 Proxy* image name                                                     | `REPOSITORY_NAME/oauth2-proxy` |
| `image.tag`                                         | *Oauth2 Proxy* image tag. If not set, a tag is generated using the appVersion | `""`                           |
| `image.pullPolicy`                                  | *Oauth2 Proxy* image pull policy                                              | `IfNotPresent`                 |
| `image.pullSecrets`                                 | Specify registry secret names as an array                                     | `[]`                           |
| `resources.requests.cpu`                            | Set containers' CPU request                                                   | `300m`                         |
| `resources.requests.memory`                         | Set containers' memory request                                                | `512Mi`                        |
| `resources.limits.cpu`                              | Set containers' CPU limit                                                     | `500m`                         |
| `resources.limits.memory`                           | Set containers' memory limit                                                  | `800Mi`                        |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                            | `185`                          |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                          | `185`                          |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                                 | `true`                         |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                     | `false`                        |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                            | `["ALL"]`                      |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                              | `RuntimeDefault`               |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID                 | `185`                          |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID               | `185`                          |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                      | `true`                         |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem       | `185`                          |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile                   | `RuntimeDefault`               |
| `affinity`                                          | Affinity for pod assignment                                                   | `{}`                           |
| `nodeSelector`                                      | Node labels for pod assignment                                                | `{}`                           |
| `tolerations`                                       | Tolerations for pod assignment                                                | `[]`                           |

### Service Account Parameters

| Name                         | Description                                                                           | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                 | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                | `true` |

### Traffic Exposure Parameters

| Name           | Description                 | Value       |
| -------------- | --------------------------- | ----------- |
| `service.port` | *Oauth2 Proxy* service port | `4080`      |
| `service.type` | *Oauth2 Proxy* service type | `ClusterIP` |

### Istio Parameters

| Name                               | Description                                                                                                                                              | Value           |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| `istio.ingress.principal`          | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using Release namespace and serviceAccountName | `""`            |
| `istio.ingress.serviceAccountName` | Name of the Ingress service account (traefik and istio supported)                                                                                        | `traefik-proxy` |
| `istio.virtualService.enabled`     | Enable Istio traffic into *Oauth2 Proxy*                                                                                                                 | `false`         |
| `istio.virtualService.host`        | Host associated with *Oauth2 Proxy* If not set, 'appHostDomain' will be used                                                                             | `""`            |
