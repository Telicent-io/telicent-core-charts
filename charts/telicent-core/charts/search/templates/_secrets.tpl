{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Create the name of the elastic / opensearch secret
*/}}
{{- define "search.elasticSecretName" -}}
{{- if .Values.elastic.existingSecret }}
{{- .Values.elastic.existingSecret }}
{{- else }}
{{- printf "tc-auth-usr-%s-%s" "elastic" .Chart.Name }}
{{- end }}
{{- end -}}
