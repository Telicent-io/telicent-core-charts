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
Returns the service name, used by routes configuration files.
a.) installed through the parent chart, the service name will include the release name.
b.) installed through a sub chart, where the srelease name equals 'traefik proxy' (chart name) the
    release name will not be included.
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
