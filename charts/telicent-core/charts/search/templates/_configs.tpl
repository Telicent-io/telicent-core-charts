{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the config map
*/}}
{{- define "search.envConfigMapName" -}}
{{- if .Values.configuration.existingEnvConfigMap }}
{{- .Values.configuration.existingEnvConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "env" }}
{{- end }}
{{- end }}
