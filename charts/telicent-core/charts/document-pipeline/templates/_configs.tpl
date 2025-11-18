{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the config map for http-ingester
*/}}
{{- define "http-ingester.configMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "http-ingester" }}
{{- end }}
