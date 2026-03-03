{{/*
Copyright (C) Telicent Limited
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

{{/*
Create the name of the server config map
*/}}
{{- define "grpc-server.serverConfigMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "server" }}
{{- end }}

{{/*
Create the name of the storage config map
*/}}
{{- define "grpc-server.storageConfigMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "storage" }}
{{- end }}
