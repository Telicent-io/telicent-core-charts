{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the elastic / opensearch secret
*/}}
{{- define "search-projector.elasticSecretName" -}}
{{- if .Values.elastic.existingSecret }}
{{- .Values.elastic.existingSecret }}
{{- else }}
{{- printf "tc-auth-usr-%s-%s"  "elastic" .Chart.Name }}
{{- end }}
{{- end -}}

{{/*
Create the name of environment variable secrets
*/}}
{{- define "search-projector.EnvSecretName" -}}
{{ include "search-projector.fullname" . }}
{{- end }}
