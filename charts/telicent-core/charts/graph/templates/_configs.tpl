{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the config map
*/}}
{{- define "graph.envConfigMapName" -}}
{{- if .Values.configuration.existingEnvConfigMap }}
{{- .Values.configuration.existingEnvConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "env" }}
{{- end }}
{{- end }}


{{/*
Create a fuseki config name to use
*/}}
{{- define "graph.fusekiConfigMapName" -}}
{{- if .Values.configuration.existingFusekiConfigMap }}
{{- .Values.configuration.existingFusekiConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "fuseki" }}
{{- end }}
{{- end }}

{{/*
Create Kafka Auth Config name to use
*/}}
{{- define "graph.kafkaAuthConfig" -}}
{{- printf "tc-%s-%s" .Chart.Name "kafka-config" }}
{{- end }}
