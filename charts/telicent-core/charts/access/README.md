# Telicent Package for Access

Telicent Access allows for testing and demonstrating of Attribute-Based Access Control (ABAC) capabilities within
Telicent CORE.

## Introduction

This chart bootstraps Telicent Access deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/access
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
 --values=charts/telicent-core/charts/access/values.yaml \
 --readme=charts/telicent-core/charts/access/README.md \
 --schema=charts/telicent-core/charts/access/values.schema.json
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
| `global.groupsClaim`                | Key used to retrieve groups from the OIDC provider                                | `groups`           |
| `global.istioNamespace`             | Namespace in which Istio is deployed                                              | `istio-system`     |
| `global.istioServiceAccountName`    | Name of the Istio service account                                                 | `istio-ingress`    |
| `global.istioGatewayName`           | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)         | `ingress-gateway`  |
| `global.istioVirtualServiceEnabled` | Enable Istio traffic routing to a named destination service                       | `true`             |

### Configuration Parameters

Contains configuration parameters specific to the *Access* application

| Name                                       | Description                                | Value                      |
| ------------------------------------------ | ------------------------------------------ | -------------------------- |
| `configuration.debug`                      | Enable debug logging                       | `true`                     |
| `configuration.openidProviderUrl`          | The URL of the OIDC provider               | `https://oidc.example.com` |
| `configuration.scimEnabled`                | Enable SCIM user management                | `true`                     |
| `configuration.telicentPreviewReleaseName` | Release name of the Telicent Preview chart | `telicent-preview`         |

### Common Parameters

| Name                       | Description                                                            | Value |
| -------------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`             | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`         | String to fully override the generated release name                    | `""`  |
| `namespaceOverride`        | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`             | Add labels to all the deployed resources                               | `{}`  |
| `existingConfigmap`        | Name of the existing configmap for configuration                       | `""`  |
| `existingCacertConfigmap`  | Name of the existing configmap for extra certificates                  | `""`  |
| `existingCacertSecretName` | Name of the secret containing extra CA certificates                    | `""`  |
| `cacert`                   | Path to the CA certificate file                                        | `""`  |

### MongoDB Parameters

| Name                            | Description                                                                                                                                                                    | Value                                             |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------- |
| `mongo.host`                    | MongoDB One or more host addresses, 'host1[:port1][,...hostN[:portN]]'                                                                                                         | `<host1>:<port1>,<host2>:<port2>,<host3>:<port3>` |
| `mongo.database`                | MongoDB database                                                                                                                                                               | `access`                                          |
| `mongo.existingSecret`          | Name of an existing secret resource containing the MongoDB username & password                                                                                                 | `""`                                              |
| `mongo.username`                | MongoDB username                                                                                                                                                               | `""`                                              |
| `mongo.password`                | MongoDB password                                                                                                                                                               | `""`                                              |
| `mongo.connectionStringOptions` | MongoDB additional connection values                                                                                                                                           | `authMechanism=SCRAM-SHA-256&retryWrites=false`   |
| `mongo.retryRewrites`           | Enable Retryable Writes                                                                                                                                                        | `false`                                           |
| `mongo.existingCaSecret`        | existingCaSecret If you have an existing secret for the CA certificate, you can specify it here. If you've specified to use TLS in the url, you must provide a CA certificate. | `""`                                              |
| `mongo.cacertPath`              | Path to the CA certificate file, must be set if TLS is enabled in the url and mirror the path in the connectionStringOptions                                                   | `""`                                              |

### Deployment Parameters

| Name                                                | Description                                                             | Value                                 |
| --------------------------------------------------- | ----------------------------------------------------------------------- | ------------------------------------- |
| `replicas`                                          | Number of *Access* replicas to deploy                                   | `1`                                   |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                  | `5`                                   |
| `annotations`                                       | Add extra annotations to the deployment object                          | `{}`                                  |
| `podLabels`                                         | Add extra labels to the *Access* pod                                    | `{}`                                  |
| `podAnnotations`                                    | Add extra annotations to the *Access* pod                               | `{}`                                  |
| `extraEnvVars`                                      | Array with extra environment variables to add to *Access* pod           | `[]`                                  |
| `extraVolumes`                                      | Additional containers to be added to the *Access* pod                   | `[]`                                  |
| `extraVolumeMounts`                                 | Optionally specify extra list of additional volumeMounts                | `[]`                                  |
| `initContainers`                                    | Add init containers to the pod                                          | `[]`                                  |
| `sidecars`                                          | Add sidecars to the pod.                                                | `[]`                                  |
| `image.registry`                                    | *Access* image registry                                                 | `REGISTRY_NAME`                       |
| `image.repository`                                  | *Access* image name                                                     | `REPOSITORY_NAME/telicent-access-api` |
| `image.tag`                                         | *Access* image tag. If not set, a tag is generated using the appVersion | `""`                                  |
| `image.pullPolicy`                                  | *Access* image pull policy                                              | `IfNotPresent`                        |
| `image.pullSecrets`                                 | Specify registry secret names as an array                               | `[]`                                  |
| `resources.requests.cpu`                            | Set containers' CPU request                                             | `250m`                                |
| `resources.requests.memory`                         | Set containers' memory request                                          | `512Mi`                               |
| `resources.limits.cpu`                              | Set containers' CPU limit                                               | `350m`                                |
| `resources.limits.memory`                           | Set containers' memory limit                                            | `768Mi`                               |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                      | `185`                                 |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                    | `185`                                 |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                           | `true`                                |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation               | `false`                               |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                      | `["ALL"]`                             |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                        | `RuntimeDefault`                      |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID           | `185`                                 |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID         | `185`                                 |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                | `true`                                |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem | `185`                                 |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile             | `RuntimeDefault`                      |
| `affinity`                                          | Affinity for pod assignment                                             | `{}`                                  |
| `nodeSelector`                                      | Node labels for pod assignment                                          | `{}`                                  |
| `tolerations`                                       | Tolerations for pod assignment                                          | `[]`                                  |

### Service Account Parameters

| Name                         | Description                                                                           | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                 | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                | `true` |

### Traffic Exposure Parameters

| Name           | Description                                                               | Value       |
| -------------- | ------------------------------------------------------------------------- | ----------- |
| `service.name` | *Access* service name. If not set, a name is generated using the fullname | `access`    |
| `service.port` | *Access* service port                                                     | `8080`      |
| `service.type` | *Access* service type                                                     | `ClusterIP` |

### Istio Parameters

| Name                                       | Description                                                                                                                                                       | Value              |
| ------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------ |
| `istio.ingress.principal`                  | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using Release namespace and serviceAccountName          | `""`               |
| `istio.ingress.serviceAccountName`         | Name of the Ingress service account (traefik and istio supported)                                                                                                 | `traefik-proxy`    |
| `istio.userPreferences.principal`          | Principal used for User Preferences traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using Release namespace and serviceAccountName | `""`               |
| `istio.userPreferences.serviceAccountName` | Name of the User Preferences service account                                                                                                                      | `user-preferences` |
| `istio.graph.principal`                    | Principal used for Graph traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using Release namespace and serviceAccountName            | `""`               |
| `istio.graph.serviceAccountName`           | Name of the Graph service account                                                                                                                                 | `graph`            |
| `istio.search.principal`                   | Principal used for Search traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using Release namespace and serviceAccountName           | `""`               |
| `istio.search.serviceAccountName`          | Name of the Search service account                                                                                                                                | `search`           |
| `istio.paperbackWriter.principal`          | Principal used for Paperback Writer traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using Release namespace and serviceAccountName | `""`               |
| `istio.paperbackWriter.serviceAccountName` | Name of the Paperback Writer service account                                                                                                                      | `paperback-writer` |


## License

Copyright &copy; 2025 Telicent Limited