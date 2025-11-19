{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the environment variables config map
*/}}
{{- define "auth.envConfigMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "env" }}
{{- end }}

{{/*
Create the name of the clients config map
*/}}
{{- define "auth.clientsConfigMapName" -}}
{{- if .Values.clients.existingConfigMap }}
{{- .Values.clients.existingConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "clients" }}
{{- end }}
{{- end }}
