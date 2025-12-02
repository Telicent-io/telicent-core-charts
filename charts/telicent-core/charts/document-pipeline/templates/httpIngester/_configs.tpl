{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the config map
*/}}
{{- define "http-ingester.routesConfigMapName" -}}
{{- if .Values.httpIngester.configMap.existingRoutesConfigMap }}
{{- .Values.httpIngester.configMap.existingRoutesConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "routes" }}
{{- end }}
{{- end }}
