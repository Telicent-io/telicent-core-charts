{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Create the name of the config map
*/}}
{{- define "notifications-projector.envConfigMapName" -}}
{{- if .Values.configMap.existingEnvConfigMap }}
{{- .Values.configMap.existingEnvConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "env" }}
{{- end }}
{{- end }}