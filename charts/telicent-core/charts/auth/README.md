# Telicent Package for Auth

**Auth** provides auth capabilities and exposes endpoints for querying user authentication.

## Introduction

This chart bootstraps Auth deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

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

Contains configuration parameters specific to the *Auth* application

| Name                                 | Description                                                            | Value                       |
| ------------------------------------ | ---------------------------------------------------------------------- | --------------------------- |
| `configuration.existingEnvConfigMap` | Name of existing configmap containing *Auth* Environment Configuration | `""`                        |
| `configuration.javaOptions`          | JVM options for the application                                        | `-XX:MaxRAMPercentage=80.0` |
| `configuration.cookieParentDomain`   | Cookie domain scope                                                    | `.telicent.io`              |
| `configuration.cookieSecure`         | Enable secure cookies                                                  | `true`                      |
| `configuration.superUserIdentifier`  | Super user identification if blank all users will be super users       | `""`                        |

### PostgreSQL Parameters and Secret

The following contains connection details to a PostgreSQL instance, on which the application relies.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-usr-psql-auth` will be created if one is not set.

| Name                         | Description                                                                        | Value |
| ---------------------------- | ---------------------------------------------------------------------------------- | ----- |
| `postgresSql.uri`            | PostgreSQL connection URI                                                          | `""`  |
| `postgresSql.existingSecret` | Name of an existing secret. The secret must contain 2 keys: 'username', 'password' | `""`  |
| `postgresSql.username`       | PostgreSQL username                                                                | `""`  |
| `postgresSql.password`       | PostgreSQL password                                                                | `""`  |

### Identity Provider (IDP) Parameters and Secret

Contains details pertinent to the OIDC Identity Provider to be used by the *Auth* OAuth application.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-gen-idp-auth` will be created if one is not set.

| Name                    | Description                                                                            | Value    |
| ----------------------- | -------------------------------------------------------------------------------------- | -------- |
| `idp.issuerUrl`         | The OpenID Connect issuer URL                                                          | `""`     |
| `idp.authorizationPath` | The path to use in combination with the issuer URL for authorization                   | `/auth`  |
| `idp.jwksPath`          | The path to use in combination with the issuer URL for JWKS                            | `/keys`  |
| `idp.tokenPath`         | The path to use in combination with the issuer URL for generating tokens               | `/token` |
| `idp.clientName`        | The OAuth Client Name (used for display)                                               | `""`     |
| `idp.emailClaim`        | The OIDC claim containing the user's email                                             | `email`  |
| `idp.existingSecret`    | Name of an existing secret. The secret must contain 2 keys: 'clientid', 'clientsecret' | `""`     |
| `idp.clientId`          | The OAuth Client ID                                                                    | `""`     |
| `idp.clientSecret`      | The OAuth Client Secret                                                                | `""`     |

### ForwardAuth Parameters and Secret

When making requests to the `/auth/forward` endpoint (used by reverse proxies), `X-ForwardAuth-Secret` header is required.
The secret associated with that header is defined within this section.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-gen-forward-auth` will be created if one is not set.

| Name                         | Description                                                         | Value |
| ---------------------------- | ------------------------------------------------------------------- | ----- |
| `forwardAuth.existingSecret` | Name of an existing secret. The secret must contain 1 key: 'header' | `""`  |
| `forwardAuth.header`         | The header value to be associated with the `X-ForwardAuth-Secret`.  | `""`  |

### Client(s) Parameters

List of registered clients

| Name                        | Description                                                                                                                                                                           | Value |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `clients.public`            | A list of public client objects                                                                                                                                                       | `[]`  |
| `clients.confidential`      | A list of confidential client objects                                                                                                                                                 | `[]`  |
| `clients.existingConfigMap` | Name of an existing config map resource containing all required public and confidential clients. If specified, the values for clients.public and clients.confidential will be ignored | `""`  |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                                                | Description                                                                | Value                           |
| --------------------------------------------------- | -------------------------------------------------------------------------- | ------------------------------- |
| `replicas`                                          | Number of *Auth* replicas to deploy                                        | `1`                             |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                     | `5`                             |
| `annotations`                                       | Add extra annotations to the deployment object                             | `{}`                            |
| `podLabels`                                         | Add extra labels to the *Auth* pod                                         | `{}`                            |
| `podAnnotations`                                    | Add extra annotations to the *Auth* pod                                    | `{}`                            |
| `extraEnvVars`                                      | Array with extra environment variables to add to *Auth* pod                | `[]`                            |
| `extraVolumes`                                      | Additional containers to be added to the *Auth* pod                        | `[]`                            |
| `extraVolumeMounts`                                 | Optionally specify extra list of additional volumeMounts                   | `[]`                            |
| `initContainers`                                    | Add init containers to the pod                                             | `[]`                            |
| `sidecars`                                          | Add sidecars to the pod.                                                   | `[]`                            |
| `image.registry`                                    | *Auth* image registry                                                      | `REGISTRY_NAME`                 |
| `image.repository`                                  | Auth server image name                                                     | `telicent/telicent-auth-server` |
| `image.pullPolicy`                                  | Auth server image pull policy                                              | `IfNotPresent`                  |
| `image.tag`                                         | Auth server image tag. If not set, a tag is generated using the appVersion | `""`                            |
| `image.pullSecrets`                                 | Specify registry secret names as an array                                  | `[]`                            |
| `resources.requests.cpu`                            | Set containers' CPU request                                                | `700m`                          |
| `resources.requests.memory`                         | Set containers' memory request                                             | `1024Mi`                        |
| `resources.limits.cpu`                              | Set containers' CPU limit                                                  | `1500m`                         |
| `resources.limits.memory`                           | Set containers' memory limit                                               | `2048Mi`                        |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                         | `185`                           |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                       | `185`                           |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                              | `true`                          |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                  | `false`                         |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                         | `["ALL"]`                       |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                           | `RuntimeDefault`                |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID              | `185`                           |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID            | `185`                           |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                   | `true`                          |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem    | `185`                           |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile                | `RuntimeDefault`                |
| `affinity`                                          | Affinity for pod assignment                                                | `{}`                            |
| `nodeSelector`                                      | Node labels for pod assignment                                             | `{}`                            |
| `tolerations`                                       | Tolerations for pod assignment                                             | `[]`                            |

### Service Account Parameters

| Name                         | Description                                                                       | Value  |
| ---------------------------- | --------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                             | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the name | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                              | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                            | `true` |

### Traffic Exposure Parameters

| Name           | Description         | Value       |
| -------------- | ------------------- | ----------- |
| `service.port` | *Auth* service port | `8080`      |
| `service.type` | *Auth* service port | `ClusterIP` |

### Istio Parameters

| Name                               | Description                                                                                                                                              | Value           |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| `istio.ingress.principal`          | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using Release namespace and serviceAccountName | `""`            |
| `istio.ingress.serviceAccountName` | Name of the Ingress service account (traefik and istio supported)                                                                                        | `traefik-proxy` |

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

## License

Copyright &copy; 2025 Telicent Limited