# Telicent Package for Canonicals Event

Canonicals Event is a data processing pipeline made up of loosely coupled mapper microservices, each performing a different function but sharing data via Kafka topics.

Canonical event messages are validated and then mapped into documents, geospatial data and knowledge, with region resolution enriching events with ISO 3166-2 subdivision information.

## Introduction

This chart bootstraps the Telicent Canonicals Event pipeline deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

It is an umbrella chart; all components are provided by upstream Telicent dependency charts, configured under their alias keys:

- `canonicals-event-document-mapper` (`telicent-canonicals-event-document-mapper`)
- `canonicals-event-geo-mapper` (`telicent-canonicals-event-geo-mapper`)
- `canonicals-event-knowledge-mapper` (`telicent-canonicals-event-knowledge-mapper`)
- `canonicals-event-region-resolver-mapper` (`telicent-canonicals-region-resolver-mapper`)
- `canonicals-event-json-validation-mapper` (`telicent-json-validation-mapper`)

Unset values fall back to each dependency chart's own defaults (including container images). Refer to each dependency chart for its full set of parameters.

## Umbrella chart

To enable this chart as part of the umbrella chart, please set the key: `.Values.canonicals-event.enabled: true`

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-data/charts/canonicals-event
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration and installation details

### JSON validation schema

The `telicent-json-validation-mapper` dependency requires a JSON schema to validate canonical event messages against.
No schema is shipped with this chart, so one must be provided at deployment time, either inline or by referencing an
existing ConfigMap. The Kafka source/target topics should be set alongside it, for example:

```yaml
canonicals-event-json-validation-mapper:
  configuration:
    sourceTopic: canonical.event.raw
    targetTopic: canonical.event.validated
    componentOf: canonical-events
  schema:
    name: canonical-event.schema.json
    content: |-
      { ... }
```

See the `telicent-json-validation-mapper` chart README for the full schema requirements and an example schema.

## Automating README and schema generation

```bash
.dev/readme-generator-for-helm --config=charts/telicent-data/charts/canonicals-event/readme.config \
 --values=charts/telicent-data/charts/canonicals-event/values.yaml \
 --readme=charts/telicent-data/charts/canonicals-event/README.md \
 --schema=charts/telicent-data/charts/canonicals-event/values.schema.json
```

## Parameters

### Global Parameters

Contains global parameters; these parameters are mirrored within the Telicent data umbrella chart
Global values are automatically propagated to every dependency (subchart).
Note: Only global parameters used within this chart will be listed below

| Name                                    | Description                                                                                                       | Value                                          |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `global.imageRegistry`                  | Global image registry                                                                                             | `""`                                           |
| `global.imagePullSecrets`               | Global registry secret names as an array                                                                          | `[]`                                           |
| `global.kafka.bootstrapServers`         | Comma separated list containing Kafka bootstrap servers                                                           | `kafka-bootstrap.kafka.svc.cluster.local:9092` |
| `global.kafka.existingConfigSecretName` | Name of an existing secret containing Kafka configuration (preferred over individual settings below for security) | `""`                                           |
| `global.kafka.username`                 | Username for Kafka authentication                                                                                 | `""`                                           |
| `global.kafka.password`                 | Password for Kafka authentication                                                                                 | `""`                                           |
| `global.kafka.protocol`                 | Protocol used for Kafka communication                                                                             | `SASL_SSL`                                     |
| `global.kafka.mechanism`                | SASL mechanism used for Kafka authentication                                                                      | `SCRAM-SHA-512`                                |

## License

Copyright &copy; 2026 Telicent Limited
