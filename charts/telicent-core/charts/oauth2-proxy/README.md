# Telicent Package for OAuth2 Proxy

Telicent OAuth2 Proxy provides authentication and authorization for applications by acting as a reverse proxy and integrating with OAuth2 providers.

## Introduction

This chart bootstraps OAuth2 Proxy deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.
OAuth2 Proxy is a reverse proxy and static file server that provides authentication using providers such as Google, GitHub, and OIDC.

For more information about OAuth2 Proxy, see the [official documentation](https://github.com/oauth2-proxy/oauth2-proxy).

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

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

## Parameters

### Replica Parameters

Controls the number of pod replicas for the deployment.

| Name           | Description                      | Value |
| -------------- | -------------------------------- | ----- |
| `replicaCount` | Number of pod replicas to deploy | `1`   |

### Existing Config/Secret Parameters

References to existing ConfigMaps or Secrets for environment and CA certificates.

| Name                          | Description                                             | Value |
| ----------------------------- | ------------------------------------------------------- | ----- |
| `existingEnvConfigmapName`    | Name of an existing ConfigMap for environment variables | `""`  |
| `existingCacertConfigmapName` | Name of an existing ConfigMap for CA certificates       | `""`  |
| `existingCacertSecretName`    | Name of the secret containing the CA certificates       | `""`  |
| `existingEnvSecretName`       | Name of an existing Secret for environment variables    | `""`  |

### Image Parameters

Container image configuration for the OAuth2 Proxy.

| Name               | Description                                         | Value                               |
| ------------------ | --------------------------------------------------- | ----------------------------------- |
| `image.repository` | Container image repository                          | `quay.io/oauth2-proxy/oauth2-proxy` |
| `image.pullPolicy` | Image pull policy                                   | `IfNotPresent`                      |
| `image.tag`        | Image tag (defaults to chart appVersion if not set) | `v7.12.0`                           |

### Configuration Parameters

Application Specific configuration for the OAuth2 Proxy.

| Name                                | Description                                                                                   | Value                                  |
| ----------------------------------- | --------------------------------------------------------------------------------------------- | -------------------------------------- |
| `configuration.cookieDomain`        | Domain that the cookie is valid for                                                           | `127.0.0.1.nip.io`                     |
| `configuration.cookieExpire`        | Cookie expiration duration                                                                    | `15m`                                  |
| `configuration.cookieRefresh`       | Cookie refresh duration                                                                       | `10m`                                  |
| `configuration.cookieSecret`        | Cookie secret (should be set via existingEnvSecretName) defaults to a random value if not set | `""`                                   |
| `configuration.oidcIssuerUrl`       | OIDC issuer URL                                                                               | `https://127.0.0.1.nip.io/realms/core` |
| `configuration.redirectUrlOverride` | OIDC redirect URL override (if not set, appHostDomain + /oauth2/callback will be used)        | `""`                                   |
| `configuration.oidcClientID`        | OIDC client ID                                                                                | `change-me`                            |
| `configuration.clientSecret`        | OIDC client secret (should be set via existingEnvSecretName)                                  | `change-me`                            |
| `configuration.cacert`              | Optional CA certificate data (PEM format) for validating the OIDC provider's TLS certificate  | `""`                                   |
| `imagePullSecrets`                  | Registry secret names as an array for private image repositories                              | `[]`                                   |

### Chart Naming Parameters

Override chart and release naming conventions.

| Name               | Description                                         | Value |
| ------------------ | --------------------------------------------------- | ----- |
| `nameOverride`     | String to partially override the chart name         | `""`  |
| `fullnameOverride` | String to fully override the generated release name | `""`  |

### Service Account Parameters

Service account configuration for the deployment.

| Name                         | Description                                            | Value  |
| ---------------------------- | ------------------------------------------------------ | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created  | `true` |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials | `true` |
| `serviceAccount.annotations` | Annotations to add to the service account              | `{}`   |
| `serviceAccount.name`        | The name of the service account to use                 | `""`   |

### Pod Metadata Parameters

Pod-level annotations and labels.

| Name             | Description                   | Value |
| ---------------- | ----------------------------- | ----- |
| `podAnnotations` | Annotations to add to the pod | `{}`  |
| `podLabels`      | Labels to add to the pod      | `{}`  |

### Security Context Parameters

Security context for the pod and container.

| Name                 | Description                      | Value |
| -------------------- | -------------------------------- | ----- |
| `podSecurityContext` | Pod-level security context       | `{}`  |
| `securityContext`    | Container-level security context | `{}`  |

### Service Parameters

Kubernetes Service configuration.

| Name           | Description                                      | Value       |
| -------------- | ------------------------------------------------ | ----------- |
| `service.type` | Service type (ClusterIP, NodePort, LoadBalancer) | `ClusterIP` |
| `service.port` | Service port                                     | `4080`      |

### Resources Parameters

Resource requests and limits for the container.

| Name        | Description                                    | Value |
| ----------- | ---------------------------------------------- | ----- |
| `resources` | Resource requests and limits for the container | `{}`  |

### Additional Volumes and Mounts

Additional volumes and volume mounts for the deployment.

| Name           | Description                                           | Value |
| -------------- | ----------------------------------------------------- | ----- |
| `volumes`      | Additional volumes to be added to the pod             | `[]`  |
| `volumeMounts` | Additional volume mounts to be added to the container | `[]`  |

### Scheduling Parameters

Node selection, tolerations, and affinity for pod scheduling.

| Name                      | Description                                                                                                                                                                  | Value |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `nodeSelector`            | Node selector for pod scheduling                                                                                                                                             | `{}`  |
| `tolerations`             | Tolerations for pod scheduling                                                                                                                                               | `[]`  |
| `affinity`                | Affinity rules for pod scheduling                                                                                                                                            | `{}`  |
| `istio.ingress.principal` | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using 'global.istioNamespace' and 'global.istioServiceAccountName' | `""`  |
