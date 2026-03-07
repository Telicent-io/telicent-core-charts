# Telicent GRPC Server

Telicent Paperback Writer is a starter application for querying data in Telicent CORE.

## Introduction

This chart bootstraps Telicent GRPC Server deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-preview/charts/grpc-server
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
 --values=charts/telicent-preview/charts/grpc-server/values.yaml \
 --readme=charts/telicent-preview/charts/grpc-server/README.md \
 --schema=charts/telicent-preview/charts/grpc-server/values.schema.json
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

Contains global parameters; these parameters are mirrored within the Telicent preview umbrella chart.
Note: Only global parameters used within this chart will be listed below.

| Name                                    | Description                                                                                         | Value                                          |
| --------------------------------------- | --------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `global.imageRegistry`                  | Global image registry                                                                               | `""`                                           |
| `global.imagePullSecrets`               | Global registry secret names as an array                                                            | `[]`                                           |
| `global.enabled`                        | enabled Enable *GRPC Server* deployment                                                             | `false`                                        |
| `global.sinkHostDomain`                 | Domain associated with Telicent data-sharing services. This value cannot be changed after it is set | `""`                                           |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers                                             | `kafka-bootstrap.kafka.svc.cluster.local:9092` |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration                                           | `""`                                           |
| `global.kafka.username`                 | Username for Kafka authentication                                                                   | `your.kafka.username.here`                     |
| `global.kafka.password`                 | Password for Kafka authentication                                                                   | `your.kafka.password.here`                     |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                                                               | `SASL_SSL`                                     |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication                                                        | `SCRAM-SHA-512`                                |
| `global.istioIngressNamespace`          | Namespace in which the Istio Ingress resource is deployed; overrides 'istio.ingress.namespace'      | `istio-system`                                 |
| `global.istioIngressServiceAccount`     | ServiceAccount associated with Istio ingress deployment; overrides 'istio.ingress.serviceAccount'   | `istio-ingress`                                |
| `global.istioGatewayNamespace`          | Namespace in which the Istio Gateway resource is deployed; overrides 'istio.gateway.namespace'      | `istio-system`                                 |
| `global.istioGatewayName`               | Name of the Istio Gateway resource; overrides 'istio.gateway.namespace'                             | `ingress-gateway`                              |

### Application Parameters - PostgreSQL and Secret

The following contains connection details to a PostgreSQL instance, on which the application relies.
It is recommended to store sensitive information including passwords in a Kubernetes secret and not in Helm values.
For Quick Start purposes, a secret named `tc-auth-usr-psql-grpc-server` will be created if one is not set.

| Name                      | Description                                                                        | Value |
| ------------------------- | ---------------------------------------------------------------------------------- | ----- |
| `postgres.jdbcUrl`        | PostgreSQL connection URI.                                                         | `""`  |
| `postgres.existingSecret` | Name of an existing secret. The secret must contain 2 keys: 'username', 'password' | `""`  |
| `postgres.username`       | PostgreSQL username                                                                | `""`  |
| `postgres.password`       | PostgreSQL password                                                                | `""`  |

### ConfigMap Parameters

| Name                             | Description                                                                   | Value |
| -------------------------------- | ----------------------------------------------------------------------------- | ----- |
| `configMap.existingEnvConfigMap` | Name of existing configmap containing *GRPC Server* Environment Configuration | `""`  |

### Common Parameters

| Name                | Description                                                            | Value |
| ------------------- | ---------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`  |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`  |

### Deployment Parameters

| Name                   | Description                                                        | Value |
| ---------------------- | ------------------------------------------------------------------ | ----- |
| `replicas`             | Number of *GRPC Server* replicas to deploy                         | `1`   |
| `revisionHistoryLimit` | Number of controller revisions to keep                             | `5`   |
| `annotations`          | Add extra annotations to the deployment object                     | `{}`  |
| `podLabels`            | Add extra labels to the *GRPC Server* pod                          | `{}`  |
| `podAnnotations`       | Add extra annotations to the *GRPC Server* pod                     | `{}`  |
| `extraEnvVars`         | Array with extra environment variables to add to *GRPC Server* pod | `[]`  |
| `extraVolumes`         | Optionally specify extra list of additional volumes                | `[]`  |
| `extraVolumeMounts`    | Optionally specify extra list of additional volumeMounts           | `[]`  |
| `initContainers`       | Add init containers to the pod                                     | `[]`  |
| `sidecars`             | Add sidecars to the pod                                            | `[]`  |

### Deployment Image Parameters

| Name                | Description                                                                  | Value                  |
| ------------------- | ---------------------------------------------------------------------------- | ---------------------- |
| `image.registry`    | *GRPC Server* image registry                                                 | `quay.io`              |
| `image.repository`  | *GRPC Server* image name                                                     | `telicent/grpc-server` |
| `image.tag`         | *GRPC Server* image tag. If not set, a tag is generated using the appVersion | `""`                   |
| `image.pullPolicy`  | *GRPC Server* image pull policy                                              | `IfNotPresent`         |
| `image.pullSecrets` | Specify registry secret names as an array                                    | `[]`                   |

### Deployment Resources Parameters - Requests and Limits

| Name        | Description                            | Value |
| ----------- | -------------------------------------- | ----- |
| `resources` | Resources for *GRPC Server* containers | `{}`  |

### Statefulset Security Context Parameters - Default Security Context

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
| `affinity`                                          | Affinity for pod assignment                                             | `{}`             |
| `nodeSelector`                                      | Node labels for pod assignment                                          | `{}`             |
| `tolerations`                                       | Tolerations for pod assignment                                          | `[]`             |

### Service Account Parameters

| Name                         | Description                                                                           | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                 | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                | `true` |

### Traffic Exposure Parameters

| Name           | Description                                                                    | Value       |
| -------------- | ------------------------------------------------------------------------------ | ----------- |
| `service.name` | *GRPC Server* service name. If not set, a name is generated using the fullname | `""`        |
| `service.port` | *GRPC Server* service port                                                     | `8080`      |
| `service.type` | *GRPC Server* service type                                                     | `ClusterIP` |

### Istio Parameters

| Name                              | Description                                                                 | Value             |
| --------------------------------- | --------------------------------------------------------------------------- | ----------------- |
| `istio.ingress.namespace`         | Namespace in which the Istio Ingress resource is deployed                   | `istio-system`    |
| `istio.ingress.serviceAccount`    | ServiceAccount associated with Istio ingress deployment                     | `istio-ingress`   |
| `istio.gateway.namespace`         | Namespace in which the Istio Gateway resource is deployed                   | `istio-system`    |
| `istio.gateway.name`              | Name of the Istio Gateway resource                                          | `ingress-gateway` |
| `istio.virtualService.enabled`    | Enable Istio traffic into *Traefik Proxy*                                   | `true`            |
| `istio.virtualService.extraHosts` | Additional hosts (excluding appHostDomain) to be managed by *Traefik Proxy* | `[]`              |


## License

Copyright &copy; 2025 Telicent Limited
