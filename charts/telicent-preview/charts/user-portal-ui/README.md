# Telicent Package for User Portal UI

Telicent User Portal UI is a centralized application for managing user access and navigation within the Telicent CORE platform.

## Introduction

This chart bootstraps Telicent User Portal UI deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/user-portal-ui
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```
The command removes all the Kubernetes components associated with the chart and deletes the release.

## Automating README and schema generation

```bash
.dev/readme-generator-for-helm --config=charts/readme.config \
 --values=charts/user-portal-ui/values.yaml \
 --readme=charts/user-portal-ui/README.md \
 --schema=charts/user-portal-ui/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                             | Description                                                                       | Value              |
| -------------------------------- | --------------------------------------------------------------------------------- | ------------------ |
| `global.imageRegistry`           | Global image registry                                                             | `""`               |
| `global.imagePullSecrets`        | Global registry secret names as an array                                          | `[]`               |
| `global.appHostDomain`           | Domain associated with Telicent application services                              | `apps.telicent.io` |
| `global.authHostDomain`          | Domain associated with Telicent authentication services, including OIDC providers | `auth.telicent.io` |
| `global.istioNamespace`          | Namespace in which Istio is deployed                                              | `istio-system`     |
| `global.istioServiceAccountName` | Name of the Istio service account                                                 | `istio-ingress`    |
| `global.istioGatewayName`        | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)         | `ingress-gateway`  |

### Application Configuration

| Name                | Description                                                             | Value                            |
| ------------------- | ----------------------------------------------------------------------- | -------------------------------- |
| `replicaCount`      | Number of replicas for the deployment                                   | `1`                              |
| `image.registry`    | Query UI image registry                                                 | `REGISTRY_NAME`                  |
| `image.repository`  | Query UI image name                                                     | `REPOSITORY_NAME/telicent-query` |
| `image.tag`         | Query UI image tag. If not set, a tag is generated using the appVersion | `""`                             |
| `image.pullPolicy`  | Query UI image pull policy                                              | `IfNotPresent`                   |
| `image.pullSecrets` | Specify registry secret names as an array                               | `[]`                             |
| `nameOverride`      | Override the chart name                                                 | `""`                             |
| `fullnameOverride`  | Override the full chart name                                            | `""`                             |

### Service Account Configuration

| Name                         | Description                                                                                                            | Value  |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                                                  | `true` |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials?                                                                | `true` |
| `serviceAccount.annotations` | Annotations to add to the service account                                                                              | `{}`   |
| `serviceAccount.name`        | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | `""`   |

### Pod Configuration

| Name                 | Description                   | Value |
| -------------------- | ----------------------------- | ----- |
| `podAnnotations`     | Annotations to add to the pod | `{}`  |
| `podLabels`          | Labels to add to the pod      | `{}`  |
| `podSecurityContext` | Pod security context          | `{}`  |
| `securityContext`    | Container security context    | `{}`  |

### Service Configuration

| Name           | Description  | Value       |
| -------------- | ------------ | ----------- |
| `service.type` | Service type | `ClusterIP` |
| `service.port` | Service port | `8080`      |

### Resource Configuration

| Name                          | Description                                    | Value                 |
| ----------------------------- | ---------------------------------------------- | --------------------- |
| `resources`                   | Resource limits and requests for the container | `{}`                  |
| `livenessProbe.httpGet.path`  | Liveness probe HTTP path                       | `/user-portal/health` |
| `livenessProbe.httpGet.port`  | Liveness probe HTTP port                       | `http`                |
| `readinessProbe.httpGet.path` | Readiness probe HTTP path                      | `/user-portal/health` |
| `readinessProbe.httpGet.port` | Readiness probe HTTP port                      | `http`                |

### Autoscaling Configuration

| Name                                         | Description                       | Value   |
| -------------------------------------------- | --------------------------------- | ------- |
| `autoscaling.enabled`                        | Enable autoscaling                | `false` |
| `autoscaling.minReplicas`                    | Minimum number of replicas        | `1`     |
| `autoscaling.maxReplicas`                    | Maximum number of replicas        | `100`   |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization percentage | `80`    |

### Volume Configuration

| Name           | Description                                                 | Value |
| -------------- | ----------------------------------------------------------- | ----- |
| `volumes`      | Additional volumes on the output Deployment definition      | `[]`  |
| `volumeMounts` | Additional volumeMounts on the output Deployment definition | `[]`  |

### Node Configuration

| Name           | Description                      | Value |
| -------------- | -------------------------------- | ----- |
| `nodeSelector` | Node selector for pod assignment | `{}`  |
| `tolerations`  | Tolerations for pod assignment   | `[]`  |
| `affinity`     | Affinity for pod assignment      | `{}`  |

### Istio Configuration

| Name                      | Description                                                                                                                                                                  | Value |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `istio.ingress.principal` | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using 'global.istioNamespace' and 'global.istioServiceAccountName' | `""`  |



## License

Copyright &copy; 2025 Telicent Limited