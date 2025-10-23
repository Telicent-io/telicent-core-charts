# Telicent Package for Paperback Writer

Telicent Paperback Writer is a starter application for querying data in Telicent CORE.

## Introduction

This chart bootstraps Telicent Paperback Writer deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/paperback-writer
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
 --values=charts/telicent-core/charts/paperback-writer/values.yaml \
 --readme=charts/telicent-core/charts/paperback-writer/README.md \
 --schema=charts/telicent-core/charts/paperback-writer/values.schema.json
```

## Configuration and installation details

## Parameters

### Global Parameters

Contains global parameters, these parameters are mirrored across all Telicent Core sub charts, these values will be authoritative.

| Name                                  | Description                                                                       | Value                                            |
| ------------------------------------- | --------------------------------------------------------------------------------- | ------------------------------------------------ |
| `global.imageRegistry`                | Global image registry                                                             | `""`                                             |
| `global.imagePullSecrets`             | Global registry secret names as an array                                          | `[]`                                             |
| `global.enterprise`                   | Enable enterprise mode, adding additional features and configurations             | `false`                                          |
| `global.appHostDomain`                | Domain associated with Telicent application services                              | `apps.telicent.io`                               |
| `global.authHostDomain`               | Domain associated with Telicent authentication services, including OIDC providers | `auth.telicent.io`                               |
| `global.groupsClaim`                  | Key used to retrieve groups from the OIDC provider                                | `groups`                                         |
| `global.jwksUrl`                      | Endpoint exposing multiple public keys represented as JWKs (JSON Web Key Set)     | `https://{yourAuthdomain}/.well-known/jwks.json` |
| `global.istioNamespace`               | Namespace in which Istio is deployed                                              | `istio-system`                                   |
| `global.istioServiceAccountName`      | Name of the Istio service account                                                 | `istio-ingress`                                  |
| `global.istioGatewayName`             | Name of the Istio Gateway Resource (LB operating at the edge of the mesh)         | `ingress-gateway`                                |
| `global.kafkaBootstrapUrls`           | Comma separated list containing Kafka bootstrap URLs                              | `kafka-bootstrap.kafka.svc.cluster.local:9092`   |
| `global.existingConfigSecretName`     | Name of an existing secret containing Kafka configuration                         | `""`                                             |
| `global.kafkaConfigUsername`          | Username for Kafka authentication                                                 | `your.kafka.username.here`                       |
| `global.kafkaConfigPassword`          | Password for Kafka authentication                                                 | `your.kafka.password.here`                       |
| `global.kafkaConfigProtocol`          | Protocol used for Kafka communication                                             | `SASL_SSL`                                       |
| `global.kafkaConfigMechanism`         | SASL mechanism used for Kafka authentication                                      | `SCRAM-SHA-512`                                  |
| `global.existingTruststoreSecretName` | Name of an existing secret containing the truststore                              | `""`                                             |
| `global.truststore.mountPath`         | The mount path for the truststore in the container                                | `/app/config/truststore`                         |

### Chart Parameters

| Name           | Description                                   | Value   |
| -------------- | --------------------------------------------- | ------- |
| `enabled`      | Enable paperback-writer deployment            | `false` |
| `replicaCount` | Number of paperback-writer replicas to deploy | `1`     |

### Image Parameters

| Name               | Description                                                          | Value                                |
| ------------------ | -------------------------------------------------------------------- | ------------------------------------ |
| `image.repository` | paperback-writer image repository                                    | `telicent/telicent-paperback-writer` |
| `image.pullPolicy` | paperback-writer image pull policy                                   | `IfNotPresent`                       |
| `image.tag`        | paperback-writer image tag. If not set, defaults to chart appVersion | `""`                                 |
| `imagePullSecrets` | Specify registry secret names as an array                            | `[]`                                 |
| `nameOverride`     | String to replace the name of the chart in the Chart.yaml file       | `""`                                 |
| `fullnameOverride` | String to fully override the generated release name                  | `""`                                 |

### Service Account Parameters

| Name                         | Description                                                                                                       | Value  |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Specifies whether a service account should be created                                                             | `true` |
| `serviceAccount.automount`   | Automatically mount a ServiceAccount's API credentials                                                            | `true` |
| `serviceAccount.annotations` | Additional custom annotations for the ServiceAccount                                                              | `{}`   |
| `serviceAccount.name`        | Name of the ServiceAccount to use. If not set and create is true, a name is generated using the fullname template | `""`   |

### Pod Parameters

| Name                 | Description                        | Value |
| -------------------- | ---------------------------------- | ----- |
| `podAnnotations`     | Additional annotations for the pod | `{}`  |
| `podLabels`          | Additional labels for the pod      | `{}`  |
| `podSecurityContext` | security context for the pod       | `{}`  |
| `securityContext`    | security context for the container | `{}`  |

### Service Parameters

| Name           | Description                                    | Value       |
| -------------- | ---------------------------------------------- | ----------- |
| `service.type` | paperback-writer service type                  | `ClusterIP` |
| `service.port` | paperback-writer service port                  | `8000`      |
| `resources`    | Resource requests and limits for the container | `{}`        |

### Probe Parameters

| Name                          | Description              | Value           |
| ----------------------------- | ------------------------ | --------------- |
| `livenessProbe.httpGet.path`  | Path for liveness probe  | `/availability` |
| `livenessProbe.httpGet.port`  | Port for liveness probe  | `http`          |
| `readinessProbe.httpGet.path` | Path for readiness probe | `/availability` |
| `readinessProbe.httpGet.port` | Port for readiness probe | `http`          |

### Volume Parameters

| Name           | Description                                                 | Value |
| -------------- | ----------------------------------------------------------- | ----- |
| `volumes`      | Additional volumes on the output Deployment definition      | `[]`  |
| `volumeMounts` | Additional volumeMounts on the output Deployment definition | `[]`  |
| `nodeSelector` | Node labels for pod assignment                              | `{}`  |
| `tolerations`  | Tolerations for pod assignment                              | `[]`  |
| `affinity`     | Affinity for pod assignment                                 | `{}`  |

### Application Configuration

| Name                               | Description                                                                                                                                                                  | Value           |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| `configuration.sparqlUrl`          | SPARQL endpoint URL. Defaults to http://release-name-graph.release-namespace.svc.cluster.local:3030                                                                          | `""`            |
| `configuration.sparqlUser`         | SPARQL endpoint username. Use existing secret to set these values if possible (.Values.existingSecretName)                                                                   | `""`            |
| `configuration.sparqlPwd`          | SPARQL endpoint password. Use existing secret to set these values if possible (.Values.existingSecretName)                                                                   | `""`            |
| `configuration.sparqlDefaultLabel` | Default label for SPARQL queries                                                                                                                                             | `!`             |
| `configuration.jwksDisabled`       | Disable JWKS validation                                                                                                                                                      | `false`         |
| `configuration.jwtHeader`          | JWT header name                                                                                                                                                              | `Authorization` |
| `configuration.accessApiUrl`       | URL for the Access API. Defaults to http://release-name-access-api.release-namespace.svc.cluster.local:8080                                                                  | `""`            |
| `configuration.cacertPath`         | Path to CA certs in the container                                                                                                                                            | `""`            |
| `existingConfigMapName`            | Name of an existing ConfigMap to use for configuration                                                                                                                       | `""`            |
| `existingSecretName`               | Name of an existing Secret to use for credentials                                                                                                                            | `""`            |
| `existingCacertConfigmapName`      | Name of an existing ConfigMap to use for CA certs. If not set, and cacert is provided, a ConfigMap will be created                                                           | `""`            |
| `cacert`                           | CA certificate data in PEM format                                                                                                                                            | `""`            |
| `istio.ingress.principal`          | Principal used for ingress traffic by the Istio AuthorizationPolicy. If not set, a principal is generated using 'global.istioNamespace' and 'global.istioServiceAccountName' | `""`            |


## License

Copyright &copy; 2025 Telicent Limited
