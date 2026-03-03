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

{{/*
Create the name of the client config map
*/}}
{{- define "grpc-client.clientConfigMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "client" }}
{{- end }}

{{/*
Create the name of the storage config map
*/}}
{{- define "grpc-client.storageConfigMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "storage" }}
{{- end }}
