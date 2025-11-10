# Telicent Package for Auth

**Auth** provides auth capabilities and exposes endpoints for querying user authentication.

## Introduction

This chart bootstraps Auth deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/auth
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
 --values=charts/telicent-core/charts/auth/values.yaml \
 --readme=charts/telicent-core/charts/auth/README.md \
 --schema=charts/telicent-core/charts/auth/values.schema.json
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
| `global.appHostDomain`              | Domain associated with Telicent application services                              | `apps.telicent.io` |
| `global.authHostDomain`             | Domain associated with Telicent authentication services, including OIDC providers | `auth.telicent.io` |
| `global.groupsClaim`                | Key used to retrieve groups from the OIDC provider                                | `groups`           |
| `global.istioNamespace`             | Namespace in which Istio is deployed                                              | `istio-system`     |
| `global.istioServiceAccountName`    | Name of the Istio service account                                                 | `istio-ingress`    |
| `global.istioGatewayName`           | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)         | `ingress-gateway`  |
| `global.istioVirtualServiceEnabled` | Enable Istio traffic routing to a named destination service                       | `true`             |

### Auth Parameters


### Configuration Parameters

Contains configuration parameters specific to the Auth application

| Name                                | Description                                                      | Value                 |
| ----------------------------------- | ---------------------------------------------------------------- | --------------------- |
| `configuration.tokenIssuerUrl`      | JWT token issuer URL                                             | `{baseUrl}`           |
| `configuration.superUserIdentifier` | Super user identification if blank all users will be super users | `""`                  |
| `configuration.cookieParentDomain`  | Cookie domain scope                                              | `.telicent.localhost` |
| `configuration.cookieSecure`        | Enable secure cookies                                            | `true`                |

### Clients

List of registered clients
@key clients.public A list of public client objects
- client_id: spa-client
  redirect_uris: 
    - http://spa.telicent.localhost/callback.html
  post_logout_redirect_uris: 
    - http://spa.telicent.localhost/
@key clients.confidential A list of confidential client objects
- client_id: client-1
  client_name: 'Secret Client'
  client_secret: password-1
  client_authentication_method: client_secret_post
  scope: write
@key clients.existingConfigMap Name of an existing config map resource containing all required public and confidential clients. If specified, the values for clients.public and clients.confidential will be ignored

| Name                        | Description                                                                                                                                                                           | Value |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `clients.public`            | A list of public client objects                                                                                                                                                       | `[]`  |
| `clients.confidential`      | A list of confidential client objects                                                                                                                                                 | `[]`  |
| `clients.existingConfigMap` | Name of an existing config map resource containing all required public and confidential clients. If specified, the values for clients.public and clients.confidential will be ignored | `""`  |

### External IDP

@section External IDP
@descStart
Note: It is recommended to use a Kubernetes secret for sensitive information like passwords

| Name                         | Description                                                                                                                                                                                                                                                                 | Value        |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ |
| `externalIdp.url`            | External identity provider URL                                                                                                                                                                                                                                              | `""`         |
| `externalIdp.clientName`     | Identity provider display name                                                                                                                                                                                                                                              | `Enterprise` |
| `externalIdp.clientId`       | OAuth2 client ID                                                                                                                                                                                                                                                            | `""`         |
| `externalIdp.clientSecret`   | OAuth2 client secret                                                                                                                                                                                                                                                        | `""`         |
| `externalIdp.existingSecret` | Name of an existing secret resource containing the OAuth2 client ID and secret. If specified, existing secret must contain data for EXTERNAL_IDP_CLIENT_ID and EXTERNAL_IDP_CLIENT_SECRET, and values for externalIdp.clientId and externalIdp.clientSecret will be ignored | `""`         |

### ForwardAuth

Note: It is recommended to use a Kubernetes secret for sensitive information like passwords

| Name                         | Description                                                                                                                                                                                             | Value |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `forwardAuth.secretValue`    | ForwardAuth security secret                                                                                                                                                                             | `""`  |
| `forwardAuth.existingSecret` | Name of an existing secret resource containing the ForwardAuth secret value. If specified, existing secret must contain data for POSTGRES_PASSWORD, and the value for postgres.password will be ignored | `""`  |

### PostgreSQL

Note: It is recommended to use a Kubernetes secret for sensitive information like passwords

| Name                      | Description                                                                                                                                                                                        | Value |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `postgres.uri`            | PostgreSQL connection URL                                                                                                                                                                          | `""`  |
| `postgres.username`       | PostgreSQL username                                                                                                                                                                                | `""`  |
| `postgres.password`       | PostgreSQL password                                                                                                                                                                                | `""`  |
| `postgres.existingSecret` | Name of an existing secret resource containing the PostgreSQL password. If specified, existing secret must contain data for POSTGRES_PASSWORD, and the value for postgres.password will be ignored | `""`  |

### Common Parameters

| Name               | Description                                                            | Value |
| ------------------ | ---------------------------------------------------------------------- | ----- |
| `fullnameOverride` | String to fully override the generated release name                    | `""`  |
| `nameOverride`     | String to partially override fullname (will maintain the release name) | `""`  |

### image This sets the container image more information can be found here: https://kubernetes.io/docs/concepts/containers/images/

| Name                | Description                                                                | Value                  |
| ------------------- | -------------------------------------------------------------------------- | ---------------------- |
| `image.registry`    | Auth server image registry                                                 | `quay.io`              |
| `image.repository`  | Auth server image name                                                     | `telicent-auth-server` |
| `image.pullPolicy`  | Auth server image pull policy                                              | `IfNotPresent`         |
| `image.tag`         | Auth server image tag. If not set, a tag is generated using the appVersion | `""`                   |
| `image.pullSecrets` | Specify registry secret names as an array                                  | `[]`                   |

### Service Account Parameters This section builds out the service account more information can be found here: https://kubernetes.io/docs/concepts/security/service-accounts/

| Name                         | Description                                                                                     | Value |
| ---------------------------- | ----------------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.name`        | Name of the created ServiceAccount. If not set, a name is generated using the fullname template | `""`  |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                            | `{}`  |

### Deployment Parameters For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/

| Name                                                | Description                                                             | Value            |
| --------------------------------------------------- | ----------------------------------------------------------------------- | ---------------- |
| `podAnnotations`                                    | Add extra annotations to the Deployment object                          | `{}`             |
| `extraEnvs`                                         | List of additional environment variables to set in the pod              | `[]`             |
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

### Traffic Exposure Parameters

| Name                        | Description                    | Value       |
| --------------------------- | ------------------------------ | ----------- |
| `service.port`              | Auth server service port       | `9000`      |
| `service.type`              | Auth server service port       | `ClusterIP` |
| `resources.requests.cpu`    | Set containers' CPU request    | `500m`      |
| `resources.requests.memory` | Set containers' memory request | `2000Mi`    |
| `resources.limits.cpu`      | Set containers' CPU limit      | `2000m`     |
| `resources.limits.memory`   | Set containers' memory limit   | `4000Mi`    |

### Probes This is to setup the liveness and readiness probes, more information can be found here: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/

| Name                          | Description                                        | Value              |
| ----------------------------- | -------------------------------------------------- | ------------------ |
| `livenessProbe.httpGet.path`  | The path to use for the Auth server liveness probe | `/actuator/health` |
| `livenessProbe.httpGet.port`  | The port to use for the Auth server liveness probe | `http`             |
| `readinessProbe.httpGet.path` | The path to use for the Auth server liveness probe | `/actuator/health` |
| `readinessProbe.httpGet.port` | The port to use for the Auth server liveness probe | `http`             |

### Node Selection

| Name                      | Description                                                                                                                                                                                      | Value |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----- |
| `nodeSelector`            | Allows you to schedule pods on a node with a label matching the given key-value pair.                                                                                                            | `{}`  |
| `affinity`                | Allows you to define affinity rules for scheduling pods, see: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/                                                           | `{}`  |
| `tolerations`             | ALlows you to schedule pods on nodes with specified taints, see: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/                                                   | `[]`  |
| `istio.ingress.principal` | Principal used for ingress traffic to this application by the Istio AuthorizationPolicy. If not set, a principal is generated using 'global.istioNamespace' and 'global.istioServiceAccountName' | `""`  |

## License

Copyright &copy; 2025 Telicent Limited