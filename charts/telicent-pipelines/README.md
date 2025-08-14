# Helm Chart for Telicent Pipelines

Telicent Pipelines is the umbrella chart under which all the subcharts are configured and released.

## Introduction

This chart bootstraps Telicent Pipelines deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-pipelines
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```
The command removes all the Kubernetes components associated with the chart and deletes the release.

## Automating README and schema generation

```bash
.dev/readme-generator-for-helm --config=charts/telicent-pipelines/readme.config \
 --values=charts/telicent-pipelines/values.yaml \
 --readme=charts/telicent-pipelines/README.md \
 --schema=charts/telicent-pipelines/values.schema.json
```

## Configuration and installation details

## Parameters

### serviceAccount

| Name                         | Description                                 | Value       |
| ---------------------------- | ------------------------------------------- | ----------- |
| `serviceAccount.name`        | Name of the service account used by the job | `producers` |
| `serviceAccount.annotations` | Annotations for the service account @object | `{}`        |

### jobs

| Name           | Description            | Value          |
| -------------- | ---------------------- | -------------- |
| `jobs[0].name` | Name of the job @array | `ontology-ies` |

## Subchart configurations

This section contains configurations for the various subcharts included in the Telicent Pipelines chart.
Each subchart can be configured independently, allowing for flexibility in deployment.
They are addressed by their names, and each subchart has its own set of configuration parameters.

## License

Copyright &copy; 2025 Telicent Limited
