{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the config map
*/}}
{{- define "paperback-writer.configMapName" -}}
{{- if .Values.configMap.existingConfigMapName }}
{{- .Values.configMap.existingEnvConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "env" }}
{{- end }}
{{- end }}
