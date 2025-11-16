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
{{- printf "tc-%s-%s" (include "graph.fullname" .) "env" }}
{{- end }}
{{- end }}


{{/*
Create a fuseki config name to use
*/}}
{{- define "graph.fusekiConfig" -}}
{{- printf "tc-%s-%s" (include "graph.fullname" .) "fuseki" }}
{{- end }}

{{/*
Create Kafka Auth Config name to use
*/}}
{{- define "graph.kafkaAuthConfig" -}}
{{- printf "tc-%s-%s" (include "graph.fullname" .) "kafka-config" }}
{{- end }}
