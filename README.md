# Telicent CORE Helm 
## Installation

To install the Telicent CORE Helm chart, use the following commands:

```sh
helm repo add telicent https://charts.telicent.io 
helm repo update
helm install my-release telicent/core
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
