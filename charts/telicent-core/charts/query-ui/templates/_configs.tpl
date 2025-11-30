{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the config map
*/}}
{{- define "query-ui.configMapName" -}}
{{- if .Values.configMap.existingConfigMap }}
{{- .Values.configMap.existingConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "env-configjs" }}
{{- end }}
{{- end }}
