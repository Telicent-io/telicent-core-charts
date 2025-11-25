# Telicent Package for Data Catalog

Telicent Data Catalog UI provides metadata management and data discovery capabilities within Telicent CORE, allowing users to catalog, search, and manage data assets across the platform.

## Introduction

This chart bootstraps Telicent Data Catalog UI deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/data-catalog-ui
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
 --values=charts/telicent-core/charts/data-catalog-ui/values.yaml \
 --readme=charts/telicent-core/charts/data-catalog-ui/README.md \
 --schema=charts/telicent-core/charts/data-catalog-ui/values.schema.json
```

## Configuration and installation details

## Parameters

### Configuration Parameters

Contains configuration parameters specific to the *Data Catalog UI* application

| Name                          | Description                                                                                                                                                                  | Value                           |
| ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| `configuration.oauthClientId` | The OAuth client id to be used by *Search UI*                                                                                                                                | `telicent-data-catalog-ui`      |
| `configuration.oauthScope`    | List of OAuth scopes to be used by *Search UI*                                                                                                                               | `openid profile offline_access` |
| `imagePullSecrets`            | Specify registry secret names as an array                                                                                                                                    | `[]`                            |
| `nameOverride`                | String to partially override the chart name                                                                                                                                  | `""`                            |
| `fullnameOverride`            | String to fully override the generated release name                                                                                                                          | `""`                            |
| `serviceAccount.create`       | Specifies whether a service account should be created                                                                                                                        | `true`                          |
| `serviceAccount.automount`    | Automatically mount a ServiceAccount's API credentials?                                                                                                                      | `true`                          |
| `serviceAccount.annotations`  | Annotations to add to the service account                                                                                                                                    | `{}`                            |
| `serviceAccount.name`         | The name of the service account to use                                                                                                                                       | `""`                            |
| `podAnnotations`              | Annotations to add to the Data Catalog pods                                                                                                                                  | `{}`                            |
| `podLabels`                   | Labels to add to the Data Catalog pods                                                                                                                                       | `{}`                            |
| `podSecurityContext`          | Security context for the Data Catalog pods                                                                                                                                   | `{}`                            |
| `securityContext`             | Security context for the Data Catalog containers                                                                                                                             | `{}`                            |
| `service.type`                | The service type for the Data Catalog                                                                                                                                        | `ClusterIP`                     |
| `service.port`                | The service port for the Data Catalog                                                                                                                                        | `8080`                          |
| `resources`                   | Resource requests and limits for the Data Catalog                                                                                                                            | `{}`                            |
| `livenessProbe.httpGet.path`  | The HTTP path for the liveness probe                                                                                                                                         | `/`                             |
| `livenessProbe.httpGet.port`  | The HTTP port for the liveness probe                                                                                                                                         | `http`                          |
| `readinessProbe.httpGet.path` | The HTTP path for the readiness probe                                                                                                                                        | `/`                             |
| `readinessProbe.httpGet.port` | The HTTP port for the readiness probe                                                                                                                                        | `http`                          |
| `volumes`                     | Additional volumes for the Data Catalog                                                                                                                                      | `[]`                            |
| `volumeMounts`                | Additional volume mounts for the Data Catalog                                                                                                                                | `[]`                            |
| `nodeSelector`                | Node selector for the Data Catalog pods                                                                                                                                      | `{}`                            |
| `tolerations`                 | Tolerations for the Data Catalog pods                                                                                                                                        | `[]`                            |
| `affinity`                    | Affinity rules for the Data Catalog pods                                                                                                                                     | `{}`                            |
| `istio.ingress.principal`     | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using 'global.istioNamespace' and 'global.istioServiceAccountName' | `""`                            |


## License

Copyright &copy; 2025 Telicent Limited