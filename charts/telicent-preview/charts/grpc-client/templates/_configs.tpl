{{/*
Copyright (C) Telicent Limited
*/}}

{{/*
Create the name of the config map
*/}}
{{- define "grpc-client.configMapName" -}}
{{- if .Values.configMap.existingConfigMapName }}
{{- .Values.configMap.existingEnvConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "env" }}
{{- end }}
{{- end }}
