# Telicent CORE Helm

## Installation

To install the Telicent CORE Helm chart, use the following commands:

```sh
helm repo add --username <GithubUsername> --password <GithubPAT*> telicent-core-charts 'https://raw.githubusercontent.com/Telicent-io/telicent-core-charts/gh-pages'
helm repo update
helm search repo telicent-charts
helm install my-release telicent-core --values <path-to-your-values-file.yaml>
```

Replace `my-release` with your desired release name.

## Upgrading

To upgrade an existing release:

```sh
helm upgrade my-release telicent/core
```

## Uninstalling

To uninstall the chart:

```sh
helm uninstall my-release
```

For more configuration options, see the [values.yaml](./values.yaml) file.

\*For details [see here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) (PAT must have read access to this repo)

## Values

| Key                                   | Type     | Default Value                                           | Description                                                                 |
|---------------------------------------|----------|-------------------------------------------------------|-----------------------------------------------------------------------------|
| `global.enterprise`                   | boolean  | `false`                                               | Indicates if the deployment is for the enterprise version.                  |
| `global.existingKafkaConfigSecretName` | string  | `""`                                                  | Name of an existing secret containing Kafka configuration.                  |
| `global.kafkaConfigProtocol`          | string   | `"SASL_SSL"`                                          | Protocol used for Kafka communication.                                      |
| `global.kafkaConfigMechanism`         | string   | `"SCRAM-SHA-512"`                                     | SASL mechanism used for Kafka authentication.                               |
| `global.kafkaConfigUsername`          | string   | `"your.kafka.username.here"`                          | Username for Kafka authentication.                                          |
| `global.kafkaConfigPassword`          | string   | `"your.kafka.password.here"`                          | Password for Kafka authentication.                                          |
| `global.appHostDomain`                | string   | `"apps.yourdomain.com"`                               | Domain for the Telicent applications.                                       |
| `global.authHostDomain`               | string   | `"auth.yourdomain.com"`                               | Domain for the Telicent authentication service.                             |
| `global.jwksUrl`                      | string   | `"https://yourdomain.com/.well-known/jwks.json"`      | URL for the JSON Web Key Set (JWKS).                                        |
| `global.kafkaBootstrapUrls`           | string   | `"kafka-kafka-bootstrap.kafka-dev.svc.cluster.local:9092"` | List of Kafka bootstrap URLs.         
| `access-api`                 | object  | {}     | [See access-api README](./charts/telicent-core/charts/access-api/README.md)|
| `access-ui`                  | object  | {}     | [See access-ui README](./charts/telicent-core/charts/access-ui/README.md)  |
| `graph-ui`                   | object  | {}     | [See graph-ui README](./charts/telicent-core/charts/graph-ui/README.md)    |
| `query-ui`                   | object  | {}     | [See query-ui README](./charts/telicent-core/charts/query-ui/README.md)    |
| `search-ui`                  | object  | {}     | [See search-ui README](./charts/telicent-core/charts/search-ui/README.md)  |
| `smart-cache-graph`          | object  | {}     | [See smart-cache-graph README](./charts/telicent-core/charts/smart-cache-graph/README.md)|
| `smart-cache-search`          | object  | {}     | [See smart-cache-search README](./charts/telicent-core/charts/smart-cache-search/README.md)|
| `user-preferences-api`          | object  | {}     | [See user-preferences-api README](./charts/telicent-core/charts/user-preferences-api/README.md)|                                     |
| `jobServiceAccountName`               | string   | `"producers"`                                         | Service account used for running jobs in Kubernetes.                        |
| `jobs.example.enabled`           | boolean  | `false`                                               | Flag to enable or disable the example job.                             |
| `jobs.example.completedTtl`      | integer  | `30`                                                  | Time-to-live for completed example jobs.                               |
| `jobs.example.serviceAccountName` | string  | `"producers"`                                         | Service account name for the example job.                              |
| `jobs.example.kafkaAuthSecretName` | string  | `"kafka-auth-config"`                                 | Name of the secret containing Kafka authentication configuration.           |
| `jobs.example.image.pullPolicy`  | string   | `"IfNotPresent"`                                      | Image pull policy for the example job.                                 |
| `jobs.example.image.repository`  | string   | `"098669589541.dkr.ecr.eu-west-2.amazonaws.com/telicent-ies-ontology-producer"` | Docker repository for the example job image.                          |
| `jobs.example.image.tag`         | string   | `"0.2.0"`                                             | Image tag for the example job.                                         |
| `jobs.example.configuration.TARGET_TOPIC` | string | `"ontology"`                                          | Kafka topic to which the example job will produce messages.            |
| `jobs.example.configuration.PRODUCER_NAME` | string | `"ies-ontology-producer"`                            | Name of the producer for the example job.                              |
| `jobs.example.configuration.SOURCE_NAME` | string | `"ies-ontology"`                                      | Name of the source for the example job.                                |
| `jobs.example.configuration.KAFKA_CONFIG_MODE` | string | `"toml"`                                             | Kafka configuration mode for the example job.                          |
| `jobs.example.configuration.KAFKA_CONFIG_FILE_PATH` | string | `"/app/config/kafka-auth/kafka-config.toml"`         | Path to the Kafka configuration file for the example job.              |
| `jobs.example.resources`         | object   | `null`                                                | Resource requests and limits for the example job container.            |

## Usage

To customize the values, create a `values.yaml` file and override the default values as needed.

```bash
helm install my-release ./telicent-core -f [values.yaml](http://_vscodecontentref_/1)