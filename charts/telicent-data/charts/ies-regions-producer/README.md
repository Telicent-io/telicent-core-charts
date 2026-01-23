# IES Regions Producer

A Kafka producer component that operates as part of the Telicent Data parent chart, designed to publish IES (Information Exchange Standard) regions data to Kafka topics for geographical data processing and analysis.

## Overview

This chart deploys the IES Regions Producer, which processes and publishes IES regions data to configured Kafka topics within the Telicent data ecosystem. The producer enables geographical data processing and spatial analysis capabilities.

## Prerequisites

- Kubernetes cluster
- Helm 3.x
- Access to Kafka cluster
- Telicent Data parent chart deployed

## Installation

This chart is typically installed as a dependency of the `telicent-data` parent chart:

```bash
helm dependency update ../telicent-data
```

```bash
helm install telicent-data ../telicent-data
```

To install this chart independently:

```bash
helm install ies-regions-producer .
```

## Dependencies

- Kafka cluster (configured via parent chart)
- Telicent Core components

## Parameters

### Global Parameters

Contains global parameters. Not explicitly used in this chart, added to maintain consistency across Telicent charts.
These parameters can be referenced in sub-charts as `.Values.global.<parameter-name>`.

| Name                             | Description                                                                                                                     | Value                                            |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| `global.imageRegistry`           | Global image registry                                                                                                           | `""`                                             |
| `global.imagePullSecrets`        | Global registry secret names as an array                                                                                        | `[]`                                             |
| `global.enterprise`              | Enable enterprise mode, adding additional features and configurations                                                           | `false`                                          |
| `global.appHostDomain`           | Domain associated with Telicent application services. This value cannot be changed after it is set                              | `""`                                             |
| `global.authHostDomain`          | Domain associated with Telicent authentication services, including OIDC providers. This value cannot be changed after it is set | `""`                                             |
| `global.groupsClaim`             | Key used to retrieve groups from the OIDC provider                                                                              | `groups`                                         |
| `global.jwksUrl`                 | Endpoint exposing multiple public keys represented as JWKs (JSON Web Key Set)                                                   | `https://{yourAuthdomain}/.well-known/jwks.json` |
| `global.istioNamespace`          | Namespace in which Istio is deployed                                                                                            | `istio-system`                                   |
| `global.istioServiceAccountName` | Name of the Istio service account                                                                                               | `istio-ingress`                                  |
| `global.istioGatewayName`        | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)                                                       | `ingress-gateway`                                |

### Kafka Parameters

| Name                                    | Description                                                                                                       | Value                                          |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers                                                           | `kafka-bootstrap.kafka.svc.cluster.local:9092` |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration (preferred over individual settings below for security) | `""`                                           |
| `global.kafka.username`                 | Username for Kafka authentication                                                                                 | `""`                                           |
| `global.kafka.password`                 | Password for Kafka authentication                                                                                 | `""`                                           |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                                                                             | `SASL_SSL`                                     |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication                                                                      | `SCRAM-SHA-512`                                |
| `global.truststore.existingSecret`      | Name of an existing secret containing the truststore                                                              | `""`                                           |
| `global.truststore.mountPath`           | The mount path for the truststore in the container                                                                | `/app/config/truststore`                       |

### Deployment Parameters

| Name           | Description                  | Value |
| -------------- | ---------------------------- | ----- |
| `replicaCount` | Number of replicas to deploy | `1`   |

### Image Parameters

| Name                | Description                                                              | Value                              |
| ------------------- | ------------------------------------------------------------------------ | ---------------------------------- |
| `image.registry`    | Container image registry                                                 | `quay.io`                          |
| `image.repository`  | Container image name                                                     | `telicent/tc-ies-regions-producer` |
| `image.tag`         | Container image tag. If not set, a tag is generated using the appVersion | `""`                               |
| `image.pullPolicy`  | Container image pull policy                                              | `IfNotPresent`                     |
| `image.pullSecrets` | Specify registry secret names as an array                                | `[]`                               |

### Common Parameters

| Name               | Description                                                            | Value |
| ------------------ | ---------------------------------------------------------------------- | ----- |
| `imagePullSecrets` | Global Docker registry secret names as an array                        | `[]`  |
| `nameOverride`     | String to partially override fullname (will maintain the release name) | `""`  |
| `fullnameOverride` | String to fully override the generated release name                    | `""`  |

### Job Parameters

| Name                          | Description                                                                                                                                                    | Value |
| ----------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `job.activeDeadlineSeconds`   | Specifies the duration in seconds relative to the startTime that the job may be active before the system tries to terminate it; value must be positive integer | `360` |
| `job.backoffLimit`            | Specifies the number of retries before marking this job as failed                                                                                              | `3`   |
| `job.completions`             | Specifies the desired number of successfully finished pods the job should be run with                                                                          | `1`   |
| `job.parallelism`             | Specifies the maximum desired number of pods the job should run at any given time                                                                              | `1`   |
| `job.ttlSecondsAfterFinished` | Specifies the time to live for finished Jobs, in seconds                                                                                                       | `0`   |

### Service Account Parameters

| Name                         | Description                                                                                                       | Value  |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                                             | `true` |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials?                                                           | `true` |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                                              | `{}`   |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set and create is true, a name is generated using the fullname template | `""`   |

### Pod Parameters

| Name                 | Description                            | Value |
| -------------------- | -------------------------------------- | ----- |
| `podAnnotations`     | Additional custom annotations for pods | `{}`  |
| `podLabels`          | Additional custom labels for pods      | `{}`  |
| `podSecurityContext` | Set pods' Security Context             | `{}`  |
| `securityContext`    | Set containers' Security Context       | `{}`  |

### Resource Parameters

| Name        | Description                                     | Value |
| ----------- | ----------------------------------------------- | ----- |
| `resources` | Resources for *IES Regions Producer* containers | `{}`  |

### Autoscaling Parameters

| Name                                         | Description                       | Value   |
| -------------------------------------------- | --------------------------------- | ------- |
| `autoscaling.enabled`                        | Enable Horizontal Pod Autoscaler  | `false` |
| `autoscaling.minReplicas`                    | Minimum number of replicas        | `1`     |
| `autoscaling.maxReplicas`                    | Maximum number of replicas        | `100`   |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization percentage | `80`    |

### Volume Parameters

| Name           | Description                                                 | Value |
| -------------- | ----------------------------------------------------------- | ----- |
| `volumes`      | Additional volumes on the output Deployment definition      | `[]`  |
| `volumeMounts` | Additional volumeMounts on the output Deployment definition | `[]`  |

### Node Selection Parameters

| Name           | Description                     | Value |
| -------------- | ------------------------------- | ----- |
| `nodeSelector` | Node labels for pods assignment | `{}`  |
| `tolerations`  | Tolerations for pods assignment | `[]`  |
| `affinity`     | Affinity for pods assignment    | `{}`  |

### Configuration Parameters

Contains configuration parameters specific to the application

| Name                        | Description                                | Value              |
| --------------------------- | ------------------------------------------ | ------------------ |
| `configuration.targetTopic` | Kafka topic to publish processed events to | `knowledge`        |
| `configuration.sourceName`  | Source name or identifier for the data     | `ies-regions-ttls` |
