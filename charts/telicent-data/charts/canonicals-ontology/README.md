# Telicent Package for Canonicals Ontology

Canonicals Ontology is a data processing pipeline made up of loosely coupled mapper microservices, each performing a different function but sharing data via Kafka topics.

Canonical ontology messages are validated against the canonical ontology JSON schema and then mapped into the ontology used by Telicent Core.

## Introduction

This chart bootstraps the Telicent Canonicals Ontology pipeline deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

It is an umbrella chart; all components are provided by upstream Telicent dependency charts, configured under their alias keys:

- `canonicals-ontology-json-validation-mapper` (`telicent-json-validation-mapper`)
- `canonicals-ontology-mapper` (`telicent-canonicals-ontology-mapper`)

Unset values fall back to each dependency chart's own defaults (including container images). Refer to each dependency chart for its full set of parameters.

## Umbrella chart

To enable this chart as part of the umbrella chart, please set the key: `.Values.canonicals-ontology.enabled: true`

## Prerequisites

- Kubernetes 1.23+
- Helm 3.9+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-data/charts/canonicals-ontology
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration and installation details

### Pipeline topics

The validation mapper reads raw canonical ontology messages from `canonical.ontology.raw` and writes the messages that pass
validation to `canonical.ontology.validated`, which the canonicals ontology mapper consumes. Override the topics under
`canonicals-ontology-json-validation-mapper.configuration` if your deployment uses different topic names.

### JSON validation schema

The `telicent-json-validation-mapper` dependency requires a JSON schema to validate canonical ontology messages against.
The canonical ontology schema is shipped with this chart in `files/canonical-ontology.schema.json` and delivered to the
mapper via a ConfigMap templated by this chart (`templates/schema-configmap.yaml`), which the mapper is pointed at
through `canonicals-ontology-json-validation-mapper.schema.existingConfigMapName`.

To use a different schema, reference your own ConfigMap instead; this chart's schema ConfigMap is then not created.
The ConfigMap must contain exactly one key whose name ends in `.schema.json`:

```yaml
canonicals-ontology-json-validation-mapper:
  schema:
    existingConfigMapName: my-schema-configmap
```

See the `telicent-json-validation-mapper` chart README for the full schema requirements.

## Automating README and schema generation

```bash
.dev/readme-generator-for-helm --config=charts/telicent-data/charts/canonicals-ontology/readme.config \
 --values=charts/telicent-data/charts/canonicals-ontology/values.yaml \
 --readme=charts/telicent-data/charts/canonicals-ontology/README.md \
 --schema=charts/telicent-data/charts/canonicals-ontology/values.schema.json
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

### JSON Validation Mapper Parameters

The canonical ontology JSON schema is shipped with this chart in
`files/canonical-ontology.schema.json` and delivered to the mapper via a ConfigMap templated by
this chart (see `templates/schema-configmap.yaml`). Subchart values cannot be templated, so the
ConfigMap uses the fixed name referenced below; override this value to supply a schema from
your own ConfigMap instead, in which case this chart's ConfigMap is not created.

| Name                                                                      | Description                                                                                                                                              | Value                          |
| ------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------ |
| `canonicals-ontology-json-validation-mapper.schema.existingConfigMapName` | Name of the ConfigMap containing the JSON validation schema; defaults to the ConfigMap created by this chart from `files/canonical-ontology.schema.json` | `canonicals-ontology-schema`   |
| `canonicals-ontology-json-validation-mapper.configuration.sourceTopic`    | Topic the validation mapper reads raw canonical ontology messages from                                                                                   | `canonical.ontology.raw`       |
| `canonicals-ontology-json-validation-mapper.configuration.targetTopic`    | Topic the validation mapper writes validated canonical ontology messages to                                                                              | `canonical.ontology.validated` |
| `canonicals-ontology-json-validation-mapper.configuration.componentOf`    | Pipeline this instance of the validation mapper belongs to                                                                                               | `canonicals-ontology`          |

## License

Copyright &copy; 2026 Telicent Limited
