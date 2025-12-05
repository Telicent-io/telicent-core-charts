{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the config map
*/}}
{{- define "user-preferences.envConfigMapName" -}}
{{- if .Values.configMap.existingEnvConfigMap }}
{{- .Values.configMap.existingEnvConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "env" }}
{{- end }}
{{- end }}

{{/*
Create Server config name to use
*/}}
{{- define "user-preferences.serverConfig" -}}
{{ include "user-preferences.fullname" . }}-server-config
{{- end }}

{{/* 
Create Kafka Auth Config name to use
*/}}
{{- define "user-preferences.kafkaAuthConfig" -}}
{{ include "user-preferences.fullname" . }}-kafka-config
{{- end }}
