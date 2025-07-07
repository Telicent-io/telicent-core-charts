# Telicent Package for Smart Cache Graph

Telicent Smart Cache Graph allows for testing and demonstrating of Attribute-Based Access Control (ABAC) capabilities within
Telicent CORE.

## Introduction

This chart bootstraps Telicent Smart Cache Graph deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/smart-cache-search
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
 --values=charts/telicent-core/charts/smart-cache-search/values.yaml \
 --readme=charts/telicent-core/charts/smart-cache-search/README.md \
 --schema=charts/telicent-core/charts/smart-cache-search/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored within the Telicent core umbrella chart

| Name                             | Description                                                                                       | Value              |
| -------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------ |
| `global.imageRegistry`           | Global image registry                                                                             | `""`               |
| `global.imagePullSecrets`        | Global registry secret names as an array                                                          | `[]`               |
| `global.appHostDomain`           | Domain name associated with the application                                                       | `apps.telicent.io` |
| `global.authHostDomain`          | Domain to be used for interacting with Telicent authentication services, including OIDC providers | `auth.telicent.io` |
| `global.istioServiceAccountName` | The name of the Istio service account to use for the Smart Cache Graph                            | `istio-ingress`    |
| `global.istioNamespace`          | The namespace where Istio is installed                                                            | `istio-system`     |

### Configuration Parameters

Contains configuration parameters specific to the Smart Cache Graph application
appVersion is used by default when defining an empty string

| Name                                  | Description                                       | Value                                                                                  |
| ------------------------------------- | ------------------------------------------------- | -------------------------------------------------------------------------------------- |
| `configuration.attributeHierarchyUrl` | is used to look up attribute hierarchies by name  | `http://access-api.tc-system.svc.cluster.local:8080/hierarchies/lookup/{name}`         |
| `configuration.javaOptions`           | are the JVM options for the application           | `-Xmx5120m -Xms2048m -Djavax.net.ssl.trustStore=/app/config/truststore/truststore.jks` |
| `configuration.otelMetricsExporter`   | is the OpenTelemetry metrics exporter             | `prometheus`                                                                           |
| `configuration.otelTracesExporter`    | is the OpenTelemetry traces exporter              | `none`                                                                                 |
| `configuration.userAttributesUrl`     | is the URL for the user attributes endpoint       | `http://access-api.tc-system.svc.cluster.local:8080/users/lookup/{user}`               |
| `fullnameOverride`                    | sets the full name of the chart                   | `""`                                                                                   |
| `image.pullPolicy`                    | defines the image pull policy                     | `IfNotPresent`                                                                         |
| `image.repository`                    | is the Docker repository for the image            | `telicent/smart-cache-graph`                                                           |
| `image.tag`                           | is the image tag to use                           | `""`                                                                                   |
| `imagePullSecrets`                    | is a list of secrets to use for pulling the image | `[]`                                                                                   |

### metrics configuration

| Name                   | Description                                                                                    | Value     |
| ---------------------- | ---------------------------------------------------------------------------------------------- | --------- |
| `metrics.service.port` | is the port for the Prometheus service                                                         | `9464`    |
| `metrics.service.name` | is the name for the Prometheus service                                                         | `metrics` |
| `nameOverride`         | sets a custom name for the chart it differs from fullnameOverride as it is not fully qualified | `""`      |

### podSecurityContext sets the pod security context

| Name                                     | Description                              | Value            |
| ---------------------------------------- | ---------------------------------------- | ---------------- |
| `podSecurityContext.fsGroup`             | sets the filesystem group ID for the pod | `185`            |
| `podSecurityContext.runAsGroup`          | sets the group ID for the pod            | `185`            |
| `podSecurityContext.runAsNonRoot`        | ensures the pod runs as a non-root user  | `true`           |
| `podSecurityContext.runAsUser`           | sets the user ID for the pod             | `185`            |
| `podSecurityContext.seccompProfile.type` | defines the seccomp profile type         | `RuntimeDefault` |

### persistentVolumeClaims are the persistent volume claims for the application

This section defines the persistent volume claims for the Smart Cache Graph application.
It includes the size and storage class for each volume.

| Name                                                 | Description                                  | Value     |
| ---------------------------------------------------- | -------------------------------------------- | --------- |
| `persistentVolumeClaims.backupsVolume.size`          | is the size of the backups volume            | `100Gi`   |
| `persistentVolumeClaims.backupsVolume.storageClass`  | is the storage class for the backups volume  | `gp3-enc` |
| `persistentVolumeClaims.datasetsVolume.size`         | is the size of the datasets volume           | `25Gi`    |
| `persistentVolumeClaims.datasetsVolume.storageClass` | is the storage class for the datasets volume | `gp3-enc` |
| `annotations`                                        | are additional annotations to add to the pod | `{}`      |

### containerSecurityContext sets the container security context

| Name                                                | Description                                                                                     | Value            |
| --------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ---------------- |
| `containerSecurityContext.allowPrivilegeEscalation` | prevents privilege escalation                                                                   | `false`          |
| `containerSecurityContext.capabilities.drop`        | defines the capabilities to drop                                                                | `["ALL"]`        |
| `containerSecurityContext.runAsGroup`               | sets the group ID for the container                                                             | `185`            |
| `containerSecurityContext.runAsNonRoot`             | ensures the container runs as a non-root user                                                   | `true`           |
| `containerSecurityContext.runAsUser`                | sets the user ID for the container                                                              | `185`            |
| `containerSecurityContext.seccompProfile.type`      | defines the seccomp profile type                                                                | `RuntimeDefault` |
| `containerSecurityContext.seccompProfile.type`      | RuntimeDefault uses the default runtime seccomp profile                                         | `RuntimeDefault` |
| `replicas`                                          | Number of Smart Cache Graph replicas to deploy                                                  | `1`              |
| `resources`                                         | sets the resource requests and limits for the pod                                               | `{}`             |
| `revisionHistoryLimit`                              | sets the number of old ReplicaSets to retain                                                    | `3`              |
| `service.port`                                      | is the port the service will listen on                                                          | `3030`           |
| `service.type`                                      | defines the service type                                                                        | `ClusterIP`      |
| `serviceAccount.annotations`                        | are additional annotations for the service account                                              | `{}`             |
| `serviceAccount.name`                               | Name of the created ServiceAccount. If not set, a name is generated using the fullname template | `""`             |
| `ingress.principal`                                 | is the principal to use for ingress traffic                                                     | `""`             |
