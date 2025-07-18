# Telicent Package for Access UI

Telicent Access UI is a frontend to interact with the ABAC utility.

## Introduction

This chart bootstraps Telicent Access UI deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/access-ui
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
 --values=charts/telicent-core/charts/access-ui/values.yaml \
 --readme=charts/telicent-core/charts/access-ui/README.md \
 --schema=charts/telicent-core/charts/access-ui/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                             | Description                                                                                       | Value              |
| -------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------ |
| `global.imageRegistry`           | Global image registry                                                                             | `""`               |
| `global.imagePullSecrets`        | Global registry secret names as an array                                                          | `[]`               |
| `global.appHostDomain`           | Domain name associated with Access UI                                                             | `apps.telicent.io` |
| `global.authHostDomain`          | Domain to be used for interacting with Telicent authentication services, including OIDC providers | `auth.telicent.io` |
| `global.istioServiceAccountName` | The name of the Istio service account to use for the Access API                                   | `istio-ingress`    |
| `global.istioNamespace`          | The namespace where Istio is installed                                                            | `istio-system`     |

### Configuration Parameters

Contains configuration parameters specific to the Access UI application

| Name                       | Description                        | Value                           |
| -------------------------- | ---------------------------------- | ------------------------------- |
| `configuration.signOutUrl` | The URL to be used for signing out | `https://your.host.here/logout` |

### Common Parameters

| Name               | Description                                                    | Value |
| ------------------ | -------------------------------------------------------------- | ----- |
| `fullnameOverride` | String to fully override the generated release name            | `""`  |
| `nameOverride`     | String to replace the name of the chart in the Chart.yaml file | `""`  |

### Access UI Deployment Parameters

| Name                                                | Description                                                              | Value                             |
| --------------------------------------------------- | ------------------------------------------------------------------------ | --------------------------------- |
| `replicas`                                          | Number of Access UI replicas to deploy                                   | `1`                               |
| `revisionHistoryLimit`                              | Number of controller revisions to keep                                   | `5`                               |
| `image.registry`                                    | Access UI image registry                                                 | `REGISTRY_NAME`                   |
| `image.repository`                                  | Access UI image name                                                     | `REPOSITORY_NAME/telicent-access` |
| `image.tag`                                         | Access UI image tag. If not set, a tag is generated using the appVersion | `""`                              |
| `image.pullPolicy`                                  | Access UI image pull policy                                              | `IfNotPresent`                    |
| `image.pullSecrets`                                 | Specify registry secret names as an array                                | `[]`                              |
| `resources.requests.cpu`                            | Set containers' CPU request                                              | `250m`                            |
| `resources.requests.memory`                         | Set containers' memory request                                           | `200Mi`                           |
| `resources.limits.cpu`                              | Set containers' CPU limit                                                | `350m`                            |
| `resources.limits.memory`                           | Set containers' memory limit                                             | `768Mi`                           |
| `containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser User ID                       | `185`                             |
| `containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup Group ID                     | `185`                             |
| `containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                            | `true`                            |
| `containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                | `false`                           |
| `containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                       | `["ALL"]`                         |
| `containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                         | `RuntimeDefault`                  |
| `podSecurityContext.runAsUser`                      | Set the provisioning pod's Security Context runAsUser User ID            | `185`                             |
| `podSecurityContext.runAsGroup`                     | Set the provisioning pod's Security Context runAsGroup Group ID          | `185`                             |
| `podSecurityContext.runAsNonRoot`                   | Set the provisioning pod's Security Context runAsNonRoot                 | `true`                            |
| `podSecurityContext.fsGroup`                        | Set the provisioning pod's Group ID for the mounted volumes' filesystem  | `185`                             |
| `podSecurityContext.seccompProfile.type`            | Set the provisioning pod's Security Context seccomp profile              | `RuntimeDefault`                  |

### Traffic Exposure Parameters

| Name           | Description            | Value       |
| -------------- | ---------------------- | ----------- |
| `service.port` | Access UI service port | `8080`      |
| `service.type` | Access UI service type | `ClusterIP` |

### Other Parameters

If not set, it defaults to the Istio service account in the istio-system

| Name                         | Description                                                                                     | Value |
| ---------------------------- | ----------------------------------------------------------------------------------------------- | ----- |
| `serviceAccount.name`        | Name of the created ServiceAccount. If not set, a name is generated using the fullname template | `""`  |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                            | `{}`  |
| `ingress.principal`          | is the principal to use for ingress traffic                                                     | `""`  |

## License

Copyright &copy; 2025 Telicent Limited
