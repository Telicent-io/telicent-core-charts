{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the env config map
*/}}
{{- define "http-ingester.envConfigMapName" -}}
{{- if .Values.httpIngester.configMap.existingEnvConfigMap }}
{{- .Values.httpIngester.configMap.existingEnvConfigMap }}
{{- else }}
{{- printf "tc-%s-%s-%s" .Chart.Name "http-ingester" "env" }}
{{- end }}
{{- end }}

{{/*
Create the name of the routes config map
*/}}
{{- define "http-ingester.routesConfigMapName" -}}
{{- if .Values.httpIngester.configMap.existingRoutesConfigMap }}
{{- .Values.httpIngester.configMap.existingRoutesConfigMap }}
{{- else }}
{{- printf "tc-%s-%s-%s" .Chart.Name "http-ingester" "routes" }}
{{- end }}
{{- end }}
