# Demo Prerequisite - Keycloak Realm

A small Helm chart that runs a single [keycloak-config-cli](https://github.com/adorsys/keycloak-config-cli)
Job to **create or update** Keycloak realms declaratively.

## Overview

Realm definitions are bundled with the chart under [`realms/`](./realms) and
applied (idempotent upsert) against a running Keycloak instance via its admin
REST API. The Job runs as a `post-install` / `post-upgrade` Helm hook, so realms
are reconciled on every `helm install` and `helm upgrade`.

> **Note:** This chart is not intended for production use.

## How it works

1. **Every** JSON file under `realms/*.json` is rendered into the ConfigMap (one
   key per file) and mounted at `/config`.
2. The Job authenticates to Keycloak using admin credentials read from an
   **existing Secret** (assumed to live in the same namespace as Keycloak / this
   release).
3. keycloak-config-cli imports `/config/*.json`, upserting **each** realm in turn.

The chart manages any number of realms — add or edit them by dropping JSON files
into [`realms/`](./realms), one realm per file. The bundled [`core.json`](./realms/core.json) was derived from an
existing Keycloak `core` realm, then **slimmed to only the non-default
configuration** (realm session/token settings and the custom `dev-apps` client).
Keycloak's built-in clients, client scopes, roles, and authentication flows are
created automatically and are intentionally omitted — keycloak-config-cli leaves
those defaults in place even in `managed: full` mode (verified against Keycloak
26.3).

> Internal `id` fields are deliberately **absent** from the realm file.
> keycloak-config-cli matches resources by natural key (realm name, `clientId`,
> role/flow name); a hardcoded `id` causes a `409 Conflict` on create.

## Image / Keycloak version compatibility

`adorsys/keycloak-config-cli` publishes **only Keycloak-suffixed tags** —
there is no plain `6.5.1` tag. Tags look like `<kcc-version>-<keycloak-version>`,
where the Keycloak part may be a major (`6.5.1-26`, tracks the latest 26.x
baseline) or a specific release (`6.5.1-26.1.0`). The default is `6.5.1-26`.
Override to pin to a specific Keycloak version:

```sh
--set image.tag=6.5.1-26.1.0
```

## Variable substitution (secrets and per-cluster URLs)

Realm files keep environment-specific values out of git by using
keycloak-config-cli's substitution syntax, `$(env:VAR)`. This works for **any**
string — client secrets, redirect URIs, web origins, etc. Each `$(env:VAR)` is
resolved from an environment variable on the Job container, supplied via
`configCli.extraEnv`.

> **`configCli.varSubstitution` defaults to `true`.** The bundled `core.json`
> relies on it, so **every** referenced variable must be supplied via
> `configCli.extraEnv` — a missing variable fails the import immediately with
> `Cannot resolve variable '...'`.

Sensitive values use a `secretKeyRef`; non-sensitive ones (hosts) use a plain
`value`. The container env name must match the `$(env:NAME)` placeholder; the
Secret *key* it reads from may differ.

```yaml
configCli:
  varSubstitution: true        # default
  extraEnv:
    - name: CORE_REALM_DEV_APPS_CLIENT_SECRET   # secret -> from a Secret
      valueFrom:
        secretKeyRef:
          name: keycloak-env
          key: CORE_REALM_DEV_APPS_CLIENT_SECRET
    - name: APPS_HOST                            # host -> plain value
      value: apps.example.com
```

### Variables required by the bundled `core.json`

| Variable                            | Kind   | Used for                          |
| ----------------------------------- | ------ | --------------------------------- |
| `CORE_REALM_DEV_APPS_CLIENT_SECRET` | secret | `dev-apps` client secret          |
| `APPS_HOST`                         | host   | redirect URI + web origin         |
| `AUTH_HOST`                         | host   | redirect URI                      |
| `KAFKA_UI_HOST`                     | host   | redirect URI                      |
| `IDP_HOST`                          | host   | web origin                        |

Multiple clients/realms each get their own variables — env names are
container-global, so keep them unique. See [`examples/`](./examples):

- [`values-demo.yaml`](./examples/values-demo.yaml) — per-cluster override for the
  bundled `core` realm.
- [`values-multi-realm.yaml`](./examples/values-multi-realm.yaml) +
  [`realms/analytics.json`](./examples/realms/analytics.json) — adding a second
  realm with its own client secret and host.

## Notes / caveats

- **Managed (full) mode:** keycloak-config-cli defaults to managing realm
  resources in `full` mode. It removes *custom* resources that are absent from
  the import file, but **does not** delete Keycloak's built-in defaults (default
  clients, scopes, roles, flows). Keep each realm file complete with respect to
  the custom resources you want to exist, and test against a non-production realm
  first.
- **ConfigMap size limit:** all realm files share a single ConfigMap, which
  Kubernetes caps at ~1 MiB. Keep realm files slim (see above); a large number of
  big realms could exceed the limit.

## Parameters

### Common

| Name               | Description                                                      | Value  |
| ------------------ | ---------------------------------------------------------------- | ------ |
| `enabled`          | Whether the Keycloak realm provisioning Job should be installed. | `true` |
| `nameOverride`     | String to partially override the generated fullname.             | `""`   |
| `fullnameOverride` | String to fully override the generated fullname.                 | `""`   |

### Keycloak Connection

| Name                      | Description                                                                             | Value                         |
| ------------------------- | --------------------------------------------------------------------------------------- | ----------------------------- |
| `keycloak.url`            | Base URL of the Keycloak instance to configure. Defaults to the in-cluster service.     | `http://keycloak:8080`        |
| `keycloak.loginRealm`     | The realm to authenticate the admin user against.                                       | `master`                      |
| `keycloak.existingSecret` | Name of an existing Secret (in this release's namespace) holding the admin credentials. | `keycloak-env`                |
| `keycloak.usernameKey`    | Key within the existing Secret that holds the admin username.                           | `KC_BOOTSTRAP_ADMIN_USERNAME` |
| `keycloak.passwordKey`    | Key within the existing Secret that holds the admin password.                           | `KC_BOOTSTRAP_ADMIN_PASSWORD` |

### Image

| Name               | Description                                                                                                                             | Value                         |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------- |
| `image.repository` | keycloak-config-cli image repository.                                                                                                   | `adorsys/keycloak-config-cli` |
| `image.tag`        | Image tag. Adorsys publishes only Keycloak-suffixed tags (e.g. "6.5.1-26" or "6.5.1-26.1.0"); set to match the target Keycloak version. | `6.5.1-26`                    |
| `image.pullPolicy` | Image pull policy.                                                                                                                      | `IfNotPresent`                |
| `imagePullSecrets` | Secrets for pulling the image from a private registry.                                                                                  | `[]`                          |

### keycloak-config-cli Behaviour

| Name                                  | Description                                                                                                                                                                 | Value  |
| ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| `configCli.varSubstitution`           | Enable variable substitution (e.g. $(env:VAR)) within realm files. The bundled core.json relies on this; every referenced variable must be supplied via configCli.extraEnv. | `true` |
| `configCli.importValidate`            | Validate realm files before importing.                                                                                                                                      | `true` |
| `configCli.availabilityCheck.enabled` | Wait for Keycloak to be reachable before importing.                                                                                                                         | `true` |
| `configCli.availabilityCheck.timeout` | How long to wait for Keycloak availability.                                                                                                                                 | `120s` |
| `configCli.logLevel`                  | Optional log level for keycloak-config-cli (e.g. info, debug). Empty uses the image default.                                                                                | `""`   |
| `configCli.extraEnv`                  | Additional environment variables to pass to the container.                                                                                                                  | `[]`   |

### Job

| Name                        | Description                                                                                     | Value   |
| --------------------------- | ----------------------------------------------------------------------------------------------- | ------- |
| `job.useHelmHooks`          | Run the Job as a post-install/post-upgrade Helm hook so realms are reconciled on every release. | `true`  |
| `job.backoffLimit`          | Number of retries before the Job is considered failed.                                          | `3`     |
| `job.activeDeadlineSeconds` | Maximum duration the Job may run before being terminated.                                       | `600`   |
| `job.restartPolicy`         | Pod restart policy for the Job.                                                                 | `Never` |
| `job.annotations`           | Additional annotations to add to the Job.                                                       | `{}`    |
| `job.labels`                | Additional labels to add to the Job.                                                            | `{}`    |

### Service Account

| Name                         | Description                                                                | Value  |
| ---------------------------- | -------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Whether to create a ServiceAccount for the Job.                            | `true` |
| `serviceAccount.name`        | Name of the ServiceAccount to use. Generated from the fullname when empty. | `""`   |
| `serviceAccount.annotations` | Additional ServiceAccount annotations.                                     | `{}`   |

### Pod

| Name                 | Description                                                             | Value |
| -------------------- | ----------------------------------------------------------------------- | ----- |
| `podAnnotations`     | Additional annotations for the Job pod.                                 | `{}`  |
| `podLabels`          | Additional labels for the Job pod.                                      | `{}`  |
| `podSecurityContext` | Pod-level security context for the Job pod.                             | `{}`  |
| `securityContext`    | Container-level security context for the keycloak-config-cli container. | `{}`  |
| `resources`          | Resource requests and limits for the container.                         | `{}`  |
| `nodeSelector`       | Node selector for scheduling the Job pod.                               | `{}`  |
| `tolerations`        | Tolerations for scheduling the Job pod.                                 | `[]`  |
| `affinity`           | Affinity rules for scheduling the Job pod.                              | `{}`  |

## License

Copyright &copy; 2026 Telicent Limited
