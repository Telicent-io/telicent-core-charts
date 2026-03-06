{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Create the name of the startup config map
*/}}
{{- define "traefik-proxy.startupConfigMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "startup" }}
{{- end }}

{{/*
Create the name of the routes-app config map
*/}}
{{- define "traefik-proxy.routesAppConfigMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "routes-app" }}
{{- end }}

{{/*
Create the name of the routes-api config map
*/}}
{{- define "traefik-proxy.routesApiConfigMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "routes-api" }}
{{- end }}

{{/*
Create the name of the routes-auth config map
*/}}
{{- define "traefik-proxy.routesAuthConfigMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "routes-auth" }}
{{- end }}

{{/*
Create the name of the routes-common config map
*/}}
{{- define "traefik-proxy.routesCommonConfigMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "routes-common" }}
{{- end }}
