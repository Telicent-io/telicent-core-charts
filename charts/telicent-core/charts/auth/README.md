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

Contains global parameters; these parameters are mirrored within the Telicent core umbrella chart.
Note: Only global parameters used within this chart will be listed below.

| Name                                | Description                                                                                                                                                                            | Value                    |
| ----------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `global.imageRegistry`              | Global image registry                                                                                                                                                                  | `""`                     |
| `global.imagePullSecrets`           | Global registry secret names as an array                                                                                                                                               | `[]`                     |
| `global.releaseNameTelicentPreview` | Release name used during the Telicent Preview chart installation. Note: ensure the value is correct, otherwise there will be no access to data-catalog, user-portal & paperback-writer | `""`                     |
| `global.enterprise`                 | Enable enterprise mode, adding additional features and configurations                                                                                                                  | `false`                  |
| `global.appHostDomain`              | Domain associated with Telicent application/ui services. This value cannot be changed after it is set                                                                                  | `""`                     |
| `global.apiHostDomain`              | Domain associated with Telicent Api services. This value cannot be changed after it is set                                                                                             | `""`                     |
| `global.authHostDomain`             | Domain associated with Telicent authentication services, including OIDC providers. This value cannot be changed after it is set                                                        | `""`                     |
| `global.truststore.existingSecret`  | Name of an existing secret containing the truststore                                                                                                                                   | `""`                     |
| `global.truststore.mountPath`       | The mount path for the truststore in the container                                                                                                                                     | `/app/config/truststore` |

### Application Parameters - Identity Provider (IDP) and Secret

Contains details pertinent to the OIDC Identity Provider to be used by the *Auth* OAuth application.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-gen-idp-auth` will be created if one is not set.

| Name                        | Description                                                                                                                   | Value          |
| --------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | -------------- |
| `idp.issuerUrl`             | The OpenID Connect issuer URL                                                                                                 | `""`           |
| `idp.authorizationPath`     | The path to use in combination with the issuer URL for authorization                                                          | `/auth`        |
| `idp.jwksPath`              | The path to use in combination with the issuer URL for JWKS                                                                   | `/keys`        |
| `idp.tokenPath`             | The path to use in combination with the issuer URL for generating tokens                                                      | `/token`       |
| `idp.userinfoPath`          | The path to use in combination with the issuer URL for userinfo                                                               | `/userinfo`    |
| `idp.cookieParentDomain`    | Cookie domain scope                                                                                                           | `.telicent.io` |
| `idp.cookieSecure`          | Enable secure cookies                                                                                                         | `true`         |
| `idp.superUserIdentifier`   | Super user identification, set to 'ALL' to allow for everyone to be a superuser                                               | `ALL`          |
| `idp.clientName`            | The OAuth Client Name (used for display)                                                                                      | `""`           |
| `idp.usernameClaim`         | The OIDC claim containing the attribute to be used as the username                                                            | `sub`          |
| `idp.existingSecret`        | Name of an existing secret. The secret must contain 2 keys: 'clientid', 'clientsecret'                                        | `""`           |
| `idp.clientId`              | The OAuth Client ID                                                                                                           | `""`           |
| `idp.clientSecret`          | The OAuth Client Secret                                                                                                       | `""`           |
| `idp.sessionTtl`            | Default session time-to-live duration (in hours)                                                                              | `2`            |
| `idp.sessionIdleTtl`        | Default session idle time-to-live duration (in minutes)                                                                       | `30`           |
| `idp.clientRefreshTokenTtl` | Client refresh token time-to-live duration (in hours). Total time will not exceed idp.sessionTtl even if this value is higher | `2`            |
| `idp.clientAccessTokenTtl`  | Client access token time-to-live duration (in minutes)                                                                        | `15`           |

### Application Parameters - ForwardAuth and Secret

When making requests to the `/auth/forward` endpoint (used by reverse proxies), `X-ForwardAuth-Secret` header is required.
The secret associated with that header is defined within this section.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-gen-forward-auth` will be created if one is not set.

| Name                         | Description                                                         | Value |
| ---------------------------- | ------------------------------------------------------------------- | ----- |
| `forwardAuth.existingSecret` | Name of an existing secret. The secret must contain 1 key: 'header' | `""`  |
| `forwardAuth.header`         | The header value to be associated with the `X-ForwardAuth-Secret`   | `""`  |

### Application Parameters - Java

Contains Java parameters to be used by the *Auth* application

| Name                  | Description                                                                            | Value                       |
| --------------------- | -------------------------------------------------------------------------------------- | --------------------------- |
| `java.jvmOptions`     | JVM options for the application                                                        | `-XX:MaxRAMPercentage=80.0` |
| `java.spring.profile` | Sets the Spring profile to be used. Options are: default, docker, test, and production | `production`                |

### Application Parameters - Logs

| Name                  | Description                                                                              | Value   |
| --------------------- | ---------------------------------------------------------------------------------------- | ------- |
| `logs.api.level`      | Api package Logging Level. Values include: ERROR, WARN, INFO, DEBUG, TRACE               | `INFO`  |
| `logs.service.level`  | Service package Logging Level. Values include: ERROR, WARN, INFO, DEBUG, TRACE           | `INFO`  |
| `logs.repo.level`     | Repo package Logging Level. Values include: ERROR, WARN, INFO, DEBUG, TRACE              | `WARN`  |
| `logs.security.level` | Security packageLogging Level. Values include: ERROR, WARN, INFO, DEBUG, TRACE           | `WARN`  |
| `logs.oauth2.level`   | Oauth2 package Logging Level. Values include: ERROR, WARN, INFO, DEBUG, TRACE            | `WARN`  |
| `logs.general.level`  | Logging Level for 'io.telicent.auth'. Values include: ERROR, WARN, INFO, DEBUG, TRACE    | `INFO`  |
| `logs.trace.level`    | Logging Level for 'Spring RestTemplate'. Values include: ERROR, WARN, INFO, DEBUG, TRACE | `ERROR` |

### Application Parameters - PostgreSQL and Secret

The following contains connection details to a PostgreSQL instance, on which the application relies.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-usr-psql-auth` will be created if one is not set.

| Name                         | Description                                                                        | Value |
| ---------------------------- | ---------------------------------------------------------------------------------- | ----- |
| `postgresSql.uri`            | PostgreSQL connection URI                                                          | `""`  |
| `postgresSql.existingSecret` | Name of an existing secret. The secret must contain 2 keys: 'username', 'password' | `""`  |
| `postgresSql.username`       | PostgreSQL username                                                                | `""`  |
| `postgresSql.password`       | PostgreSQL password                                                                | `""`  |

### Application Parameters - Bootstrap

Contains configuration to be used to bootstrap a clean instance of the Auth application to a working state.

| Name                                  | Description                                                                                                                                                                           | Value |
| ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `bootstrap.clients.existingConfigMap` | Name of an existing config map resource containing all required public and confidential clients. If specified, the values for clients.public and clients.confidential will be ignored | `""`  |
| `bootstrap.clients.public`            | A list of public client objects                                                                                                                                                       | `[]`  |
| `bootstrap.clients.confidential`      | A list of confidential client objects                                                                                                                                                 | `[]`  |
| `bootstrap.groups.existingConfigMap`  | Name of an existing config map containing a list of group objects                                                                                                                     | `""`  |
| `bootstrap.groups.list`               | A list containing group objects                                                                                                                                                       | `[]`  |

### ConfigMap Parameters

| Name                             | Description                                                            | Value |
| -------------------------------- | ---------------------------------------------------------------------- | ----- |
| `configMap.existingEnvConfigMap` | Name of existing configmap containing *Auth* Environment Configuration | `""`  |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                   | Description                                                 | Value |
| ---------------------- | ----------------------------------------------------------- | ----- |
| `replicas`             | Number of *Auth* replicas to deploy                         | `1`   |
| `revisionHistoryLimit` | Number of controller revisions to keep                      | `5`   |
| `annotations`          | Add extra annotations to the deployment object              | `{}`  |
| `podLabels`            | Add extra labels to the *Auth* pod                          | `{}`  |
| `podAnnotations`       | Add extra annotations to the *Auth* pod                     | `{}`  |
| `extraEnvVars`         | Array with extra environment variables to add to *Auth* pod | `[]`  |
| `extraVolumes`         | Optionally specify extra list of additional volumes         | `[]`  |
| `extraVolumeMounts`    | Optionally specify extra list of additional volumeMounts    | `[]`  |
| `initContainers`       | Add init containers to the pod                              | `[]`  |
| `sidecars`             | Add sidecars to the pod                                     | `[]`  |

### Deployment Image Parameters

| Name                | Description                                                           | Value                           |
| ------------------- | --------------------------------------------------------------------- | ------------------------------- |
| `image.registry`    | *Auth* image registry                                                 | `quay.io`                       |
| `image.repository`  | *Auth* image name                                                     | `telicent/telicent-auth-server` |
| `image.tag`         | *Auth* image tag. If not set, a tag is generated using the appVersion | `""`                            |
| `image.pullPolicy`  | *Auth* image pull policy                                              | `IfNotPresent`                  |
| `image.pullSecrets` | Specify registry secret names as an array                             | `[]`                            |

### Deployment Resources Parameters - Requests and Limits

| Name        | Description                     | Value |
| ----------- | ------------------------------- | ----- |
| `resources` | Resources for *Auth* containers | `{}`  |

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

| Name           | Description                                                             | Value       |
| -------------- | ----------------------------------------------------------------------- | ----------- |
| `service.name` | *Auth* service name. If not set, a name is generated using the fullname | `""`        |
| `service.port` | *Auth* service port                                                     | `8080`      |
| `service.type` | *Auth* service port                                                     | `ClusterIP` |

### Host(s) Parameters - Contains host information for applications deployed via *telicent-core* chart.

*Auth* interacts directly with other Telicent Applications using their default service/serviceAccount and port.
If either of those details changes, you can use this section to correctly refer to those applications.

| Name                      | Description                                                                                                                                                                                                                          | Value                   |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------- |
| `hosts.enableAutoCorrect` | Allow for the release name to be automatically pre-fixed to each host value when required (default behavior when installing through the parent chart). Alternatively, the host value will be used as it is, without any modification | `true`                  |
| `hosts.traefikProxy`      | Traefik Proxy application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                            | `traefik-proxy:8080`    |
| `hosts.userPreferences`   | User Preferences host value, If not set a host is generated using service:'user-preferences',port:'8080' and Release namespace & name                                                                                                | `user-preferences:8080` |
| `hosts.search`            | Search application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                                   | `search:8080`           |
| `hosts.graph`             | Graph application default host value, as defined by 'service/serviceAccount:port'                                                                                                                                                    | `graph:8080`            |

### Host(s) Preview Parameters - Contains host information for applications deployed via *telicent-preview* chart

Host values will be used as defined in this section, release name cannot be autocorrected, as the release name is unknown.

| Name                             | Description                                                                                                                                        | Value                   |
| -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| `hostsPreview.enableAutoCorrect` | Prefix 'global.releaseNameTelicentPreview' value to each host value. Alternatively, the host value will be used as it is, without any modification | `true`                  |
| `hostsPreview.paperbackWriter`   | Paperback Writer application host value, as defined by 'service/serviceAccount:port'                                                               | `paperback-writer:8080` |
| `hostsPreview.spatial`           |                                                                                                                                                    | `spatial:8080`          |

## License

Copyright &copy; 2025 Telicent Limited