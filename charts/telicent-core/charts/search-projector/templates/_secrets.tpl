{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the elastic / opensearch secret
*/}}
{{- define "search-projector.elasticSecretName" -}}
{{- if .Values.elasticSecret.existingSecret }}
{{- .Values.elasticSecret.existingSecret }}
{{- else }}
{{- printf "tc-auth-usr-%s-%s"  "elastic" .Chart.Name }}
{{- end }}
{{- end -}}
