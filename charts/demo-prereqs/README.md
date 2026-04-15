# Helm Chart for Demo Cluster Prerequisites

Demo Prereqs is the umbrella chart under which all prerequisites for a deployment of Telicent CORE, DATA and PREVIEW are configured and released.

## Introduction

This chart bootstraps the Telicent CORE deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes CLI (`kubectl`) version 1.3.5 This cluster has been tested using version 1.35. While it is possible that other versions will also work, they have not been tested and it is possible that one of more API's will not be supported.
- Helm CLI (`helm`) version 3 or greater.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/demo-cluster
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Automating README and schema generation

```bash
.dev/readme-generator-for-helm --config=charts/demo-cluster/readme.config \
 --values=charts/demo-cluster/values.yaml \
 --readme=charts/demo-cluster/README.md \
 --schema=charts/demo-cluster/values.schema.json
```

## Configuration and installation details

## Parameters

### Demo Prerequisites Configuration

| Name      | Description                                        | Value  |
| --------- | -------------------------------------------------- | ------ |
| `enabled` | Whether the demo prerequisite should be installed. | `true` |

## License

Copyright &copy; 2026 Telicent Limited
