# Telicent Package for OAuth2 Proxy Internal

Telicent OAuth2 Proxy Internal provides authentication and authorization for applications by acting as a reverse proxy and integrating with OAuth2 providers.

## Introduction

This chart bootstraps OAuth2 Proxy deployment on a [Kubernetes](https://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.
OAuth2 Proxy is a reverse proxy and static file server that provides authentication using providers such as Google, GitHub, and OIDC.

For more information about OAuth2 Proxy, see the [official documentation](https://github.com/oauth2-proxy/oauth2-proxy).

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release ./charts/telicent-core/charts/oauth2-proxy
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
 --values=charts/telicent-core/charts/oauth2-proxy/values.yaml \
 --readme=charts/telicent-core/charts/oauth2-proxy/README.md \
 --schema=charts/telicent-core/charts/oauth2-proxy/values.schema.json
```

## Configuration and installation details

## Parameters
