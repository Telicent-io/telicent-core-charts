# Telicent Package for AI Sparql Builder

Telicent AI Sparql Builder is an AI that takes natural language questions and translates them into SPARQL queries, which can be used to query knowledge graphs. It is designed to work with the Telicent platform, providing users with an intuitive way to interact with their data using natural language.

## Introduction

This chart bootstraps Telicent AI Sparql Builder deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/ai-sparql-builder
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
 --values=charts/telicent-core/charts/ai-sparql-builder/values.yaml \
 --readme=charts/telicent-core/charts/ai-sparql-builder/README.md \
 --schema=charts/telicent-core/charts/ai-sparql-builder/values.schema.json
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

| Name                             | Description                                                                                                                                         | Value |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `global.imageRegistry`           | Global image registry                                                                                                                               | `""`  |
| `global.imagePullSecrets`        | Global registry secret names as an array                                                                                                            | `[]`  |
| `global.releaseNameTelicentCore` | Release name used during the Telicent Core chart installation. Note: ensure the value is correct, otherwise there will be no access to auth & graph | `""`  |
| `global.appHostDomain`           | Domain associated with Telicent application/ui services. This value cannot be changed after it is set                                               | `""`  |
| `global.apiHostDomain`           | Domain associated with Telicent Api services. This value cannot be changed after it is set                                                          | `""`  |
| `global.authHostDomain`          | Domain associated with Telicent authentication services, including OIDC providers. This value cannot be changed after it is set                     | `""`  |

### ConfigMap Parameters

| Name                             | Description                                                                         | Value |
| -------------------------------- | ----------------------------------------------------------------------------------- | ----- |
| `configMap.existingEnvConfigMap` | Name of existing configmap containing *AI Sparql Builder* Environment Configuration | `""`  |

### Common Parameters

| Name                | Description                                                            | Value  |
| ------------------- | ---------------------------------------------------------------------- | ------ |
| `enabled`           | Enable or disable the *AI Sparql Builder* component                    | `true` |
| `nameOverride`      | String to partially override fullname (will maintain the release name) | `""`   |
| `fullnameOverride`  | String to fully override the generated release name                    | `""`   |
| `namespaceOverride` | String to fully override all deployed resources namespace              | `""`   |
| `commonLabels`      | Add labels to all the deployed resources                               | `{}`   |

### Deployment Parameters

| Name                   | Description                                                              | Value |
| ---------------------- | ------------------------------------------------------------------------ | ----- |
| `replicas`             | Number of *AI Sparql Builder* replicas to deploy                         | `1`   |
| `revisionHistoryLimit` | Number of controller revisions to keep                                   | `5`   |
| `annotations`          | Add extra annotations to the deployment object                           | `{}`  |
| `podLabels`            | Add extra labels to the *AI Sparql Builder* pod                          | `{}`  |
| `podAnnotations`       | Add extra annotations to the *AI Sparql Builder* pod                     | `{}`  |
| `extraEnvVars`         | Array with extra environment variables to add to *AI Sparql Builder* pod | `[]`  |
| `command`              | Override the default container command                                   | `[]`  |
| `args`                 | Override the default container args                                      | `[]`  |
| `extraVolumes`         | Optionally specify extra list of additional volumes                      | `[]`  |
| `extraVolumeMounts`    | Optionally specify extra list of additional volumeMounts                 | `[]`  |
| `initContainers`       | Add init containers to the pod                                           | `[]`  |
| `sidecars`             | Add sidecars to the pod                                                  | `[]`  |

### Deployment Image Parameters

| Name                | Description                                                                        | Value                                          |
| ------------------- | ---------------------------------------------------------------------------------- | ---------------------------------------------- |
| `image.registry`    | *AI Sparql Builder* image registry                                                 | `098669589541.dkr.ecr.eu-west-2.amazonaws.com` |
| `image.repository`  | *AI Sparql Builder* image name                                                     | `poc-sparql-chat-bot`                          |
| `image.tag`         | *AI Sparql Builder* image tag. If not set, a tag is generated using the appVersion | `""`                                           |
| `image.pullPolicy`  | *AI Sparql Builder* image pull policy                                              | `IfNotPresent`                                 |
| `image.pullSecrets` | Specify registry secret names as an array                                          | `[]`                                           |

### Deployment Resources Parameters - Requests and Limits

| Name        | Description                                  | Value |
| ----------- | -------------------------------------------- | ----- |
| `resources` | Resources for *AI Sparql Builder* containers | `{}`  |

### configuration

Application specific configuration settings

| Name                                            | Description                                                                                                                                                                                                                                                                                 | Value                      |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- |
| `configuration.CHATBOT_SPARQL_URL`              | URL of the SPARQL endpoint to query for the chatbot                                                                                                                                                                                                                                         | `""`                       |
| `configuration.CHATBOT_AUTH_SERVER_PUBLIC_URL`  | Public URL of the authentication server, used for OIDC discovery and token validation                                                                                                                                                                                                       | `""`                       |
| `configuration.CHATBOT_OAUTH_CLIENT_ID`         | OAuth client ID registered in the authentication server for the chatbot application                                                                                                                                                                                                         | `ai-sparql-builder-client` |
| `configuration.AUTH_SERVER_BASE_URL`            | Base URL of the authentication server, used for obtaining tokens. This may differ from CHATBOT_AUTH_SERVER_PUBLIC_URL if the auth server is behind a proxy or has different internal/external URLs                                                                                          | `""`                       |
| `configuration.AUTH_SERVER_ALLOW_HTTP`          | Whether to allow HTTP connections to the authentication server (true/false). Should be set to true for local development with port-forwarding, and false for production deployments with secure connections                                                                                 | `false`                    |
| `configuration.JWT_ISSUER`                      | Expected JWT issuer claim for validating tokens. Should match the issuer configured in the authentication server for the chatbot's OAuth client.                                                                                                                                            | `""`                       |
| `configuration.CHATBOT_LLM_PROVIDER`            | The LLM provider to use for the chatbot. Supported values: transformers.                                                                                                                                                                                                                    | `transformers`             |
| `configuration.CHATBOT_PROMPT_VARIANT`          | The prompt variant to use for the chatbot. Supported values: training, production. The 'training' variant includes additional context and examples in the prompt to improve response quality, while the 'production' variant uses a more concise prompt for faster responses.               | `training`                 |
| `configuration.CHATBOT_TRANSFORMERS_MODEL_PATH` | The file system path where the chatbot's Transformers models are stored. This should match the path used in the chatbot application code to load the models. In this example, it is set to '/app/models', which means the models should be mounted or copied to that path in the container. | `/app/models`              |
| `configuration.CHATBOT_SPARQL_DATASET`          | The name of the dataset to use in the SPARQL endpoint for the chatbot queries. This should match the dataset name configured in the SPARQL endpoint that contains the relevant data for the chatbot.                                                                                        | `knowledge`                |

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

### GPU Parameters

Enable GPU support for *AI Sparql Builder*. When enabled, the deployment will request GPU resources
and add the appropriate tolerations and runtime class for GPU scheduling.
Supported GPU types: nvidia.com/gpu, amd.com/gpu

| Name                          | Description                                                                                                        | Value            |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------ | ---------------- |
| `gpu.enabled`                 | Enable GPU support for the AI Sparql Builder                                                                       | `true`           |
| `gpu.type`                    | The GPU resource type to request (e.g. nvidia.com/gpu, amd.com/gpu)                                                | `nvidia.com/gpu` |
| `gpu.count`                   | Number of GPUs to request                                                                                          | `1`              |
| `gpu.runtimeClassName`        | Set the runtimeClassName for the pod (e.g. nvidia for NVIDIA GPU Operator). Leave empty to use the cluster default | `""`             |
| `gpu.tolerations[0].key`      | key for toleration to allow scheduling on GPU nodes                                                                | `nvidia.com/gpu` |
| `gpu.tolerations[0].operator` | operator for the toleration to allow scheduling on GPU nodes                                                       | `Exists`         |
| `gpu.tolerations[0].effect`   | effect for the toleration to allow scheduling on GPU nodes                                                         | `NoSchedule`     |
| `gpu.nodeAffinity.labelKey`   | Node label key used to identify GPU nodes                                                                          | `nvidia.com/gpu` |
| `gpu.nodeAffinity.operator`   | Operator for the label expression (In, Exists, etc.)                                                               | `In`             |
| `gpu.nodeAffinity.values`     | Label values to match for GPU node selection. Only used when operator is 'In'                                      | `["true"]`       |

### Service Account Parameters

| Name                         | Description                                                                           | Value  |
| ---------------------------- | ------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                 | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set, a name is generated using the fullname | `""`   |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                  | `{}`   |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                | `true` |

### Traffic Exposure Parameters

| Name           | Description                                                                          | Value       |
| -------------- | ------------------------------------------------------------------------------------ | ----------- |
| `service.name` | *AI Sparql Builder* service name. If not set, a name is generated using the fullname | `""`        |
| `service.port` | *AI Sparql Builder* service port                                                     | `8080`      |
| `service.type` | *AI Sparql Builder* service type                                                     | `ClusterIP` |

### Host(s) Core Parameters - Contains host information for applications deployed via *telicent-core* chart

*AI Sparql Builder* interacts with applications deployed via *telicent-core* using their default service/serviceAccount and port.
If either of those details changes, you can use this section to correctly refer to those applications.

| Name                          | Description                                                                                                                                     | Value                |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | -------------------- |
| `hostsCore.enableAutoCorrect` | Prefix 'global.releaseNameTelicentCore' value to each host value. Alternatively, the host value will be used as it is, without any modification | `true`               |
| `hostsCore.traefikProxy`      | Traefik Proxy application default host value, as defined by 'service/serviceAccount:port'                                                       | `traefik-proxy:8080` |
| `hostsCore.auth`              | Auth application default host value, as defined by 'service/serviceAccount:port'                                                                | `auth:8080`          |
| `hostsCore.graph`             | Graph application host value, as defined by 'service/serviceAccount:port'                                                                       | `graph:8080`         |

## License

Copyright &copy; 2025 Telicent Limited
