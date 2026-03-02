{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Create the name of the config map
*/}}
{{- define "grpc-server.configMapName" -}}
{{- if .Values.configMap.existingConfigMapName }}
{{- .Values.configMap.existingEnvConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "env" }}
{{- end }}
{{- end }}
