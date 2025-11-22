# Telicent Package for Data Catalog

Telicent Data Catalog UI provides metadata management and data discovery capabilities within Telicent CORE, allowing users to catalog, search, and manage data assets across the platform.

## Introduction

This chart bootstraps Telicent Data Catalog UI deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/data-catalog-ui
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
 --values=charts/telicent-core/charts/data-catalog-ui/values.yaml \
 --readme=charts/telicent-core/charts/data-catalog-ui/README.md \
 --schema=charts/telicent-core/charts/data-catalog-ui/values.schema.json
```

## Configuration and installation details

## Parameters


## License

Copyright &copy; 2025 Telicent Limited