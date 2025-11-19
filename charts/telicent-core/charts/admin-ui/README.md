# Telicent Package for Admin UI

Telicent Admin UI is an application for administering Telicent CORE.

## Introduction

This chart bootstraps Telicent Admin UI deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/admin-ui
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
 --values=charts/telicent-core/charts/admin-ui/values.yaml \
 --readme=charts/telicent-core/charts/admin-ui/README.md \
 --schema=charts/telicent-core/charts/admin-ui/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

| Name                                | Description                                                                       | Value              |
| ----------------------------------- | --------------------------------------------------------------------------------- | ------------------ |
| `global.enterprise`                 | Enable enterprise mode, adding additional features and configurations             | `false`            |
| `global.appHostDomain`              | Domain associated with Telicent application services                              | `apps.telicent.io` |
| `global.authHostDomain`             | Domain associated with Telicent authentication services, including OIDC providers | `auth.telicent.io` |
| `global.istioNamespace`             | Namespace in which Istio is deployed                                              | `istio-system`     |
| `global.istioServiceAccountName`    | Name of the Istio service account                                                 | `istio-ingress`    |
| `global.istioGatewayName`           | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)         | `ingress-gateway`  |
| `global.istioVirtualServiceEnabled` | Enable Istio traffic routing to a named destination service                       | `true`             |

### Admin UI Parameters


### Common Parameters

| Name               | Description                                                            | Value |
| ------------------ | ---------------------------------------------------------------------- | ----- |
| `fullnameOverride` | String to fully override the generated release name                    | `""`  |
| `nameOverride`     | String to partially override fullname (will maintain the release name) | `""`  |

### image This sets the container image more information can be found here: https://kubernetes.io/docs/concepts/containers/images/

| Name                | Description                                                                | Value               |
| ------------------- | -------------------------------------------------------------------------- | ------------------- |
| `image.registry`    | Auth server image registry                                                 | `quay.io`           |
| `image.repository`  | Auth server image name                                                     | `telicent-admin-ui` |
| `image.pullPolicy`  | Auth server image pull policy                                              | `IfNotPresent`      |
| `image.pullSecrets` | Specify registry secret names as an array                                  | `[]`                |
| `image.tag`         | Auth server image tag. If not set, a tag is generated using the appVersion | `""`                |

### image This sets the container image more information can be found here: https://kubernetes.io/docs/concepts/configuration/configmap/

| Name                              | Description                                                                                                                                    | Value |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `configMap.existingConfigMapName` | The name of an existing config map containing env-config.js. If omitted, a new config map using settings from this values file will be created | `""`  |

### Service Account Parameters This section builds out the service account more information can be found here: https://kubernetes.io/docs/concepts/security/service-accounts/

| Name                         | Description                                                                                     | Value  |
| ---------------------------- | ----------------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Whether a service account should be created                                                     | `true` |
| `serviceAccount.automount`   | Whether to automatically mount a ServiceAccount's API credentials?                              | `true` |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                            | `{}`   |
| `serviceAccount.name`        | Name of the created ServiceAccount. If not set, a name is generated using the fullname template | `""`   |

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
| `service.port`              | Auth server service port       | `8080`      |
| `service.type`              | Auth server service port       | `ClusterIP` |
| `resources.requests.cpu`    | Set containers' CPU request    | `250m`      |
| `resources.requests.memory` | Set containers' memory request | `500Mi`     |
| `resources.limits.cpu`      | Set containers' CPU limit      | `5000m`     |
| `resources.limits.memory`   | Set containers' memory limit   | `1000Mi`    |

### Node Selection

| Name                      | Description                                                                                                                                                                                      | Value |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----- |
| `nodeSelector`            | Allows you to schedule pods on a node with a label matching the given key-value pair.                                                                                                            | `{}`  |
| `affinity`                | Allows you to define affinity rules for scheduling pods, see: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/                                                           | `{}`  |
| `tolerations`             | ALlows you to schedule pods on nodes with specified taints, see: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/                                                   | `[]`  |
| `istio.ingress.principal` | Principal used for ingress traffic to this application by the Istio AuthorizationPolicy. If not set, a principal is generated using 'global.istioNamespace' and 'global.istioServiceAccountName' | `""`  |

## License

Copyright &copy; 2025 Telicent Limited