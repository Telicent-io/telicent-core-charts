{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the startup config map
*/}}
{{- define "traefik-proxy.startupConfigMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "startup" }}
{{- end }}

{{/*
Create the name of the routes config map
*/}}
{{- define "traefik-proxy.routesConfigMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "routes" }}
{{- end }}

{{/*
Returns a service name used by routes configuration files.
When installed through the parent chart the service name will include the release name.
Installed through a sub chart and release name equals traefik proxy chart name. It will not
contain a release name.
*/}}
{{- define "traefik-proxy.routesService" -}}
{{- $envVal := index . 0 -}}
{{- $service := index . 1 -}}
{{- $name := default $envVal.Chart.Name $envVal.Values.nameOverride }}
{{- if contains $name $envVal.Release.Name }}
{{- printf "%s" $service  -}}
{{- else }}
{{- printf "%s-%s" $envVal.Release.Name $service }}
{{- end }}
{{- end }}
