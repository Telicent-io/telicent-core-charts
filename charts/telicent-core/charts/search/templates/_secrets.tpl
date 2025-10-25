{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the elastic / opensearch secret
*/}}
{{- define "search.elasticSecretName" -}}
{{- if .Values.elasticSecret.existingSecret }}
{{- .Values.elasticSecret.existingSecret }}
{{- else }}
{{- printf "%s-tc-auth-usr-%s" (include "search.fullname" .) "elastic" }}
{{- end }}
{{- end -}}
