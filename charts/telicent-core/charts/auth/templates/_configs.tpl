{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Create the name of the environment variables config map
*/}}
{{- define "auth.envConfigMapName" -}}
{{- if .Values.configMap.existingEnvConfigMap }}
{{- .Values.configMap.existingEnvConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "env" }}
{{- end }}
{{- end }}

{{/*
Create the name of the startup/seed clients config map
*/}}
{{- define "auth.clientsConfigMapName" -}}
{{- if .Values.bootstrap.clients.existingConfigMap }}
{{- .Values.bootstrap.clients.existingConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "clients" }}
{{- end }}
{{- end }}

{{/*
Create the name of the startup/seed groups config map
*/}}
{{- define "auth.groupsConfigMapName" -}}
{{- if .Values.bootstrap.groups.existingConfigMap }}
{{- .Values.bootstrap.groups.existingConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "groups" }}
{{- end }}
{{- end }}
