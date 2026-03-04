{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Create the name of the environment variables config map
*/}}
{{- define "notifications.envConfigMapName" -}}
{{- if .Values.configMap.existingConfigMapName }}
{{- .Values.configMap.existingEnvConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "env" }}
{{- end }}
{{- end }}
