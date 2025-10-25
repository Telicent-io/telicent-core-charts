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
{{- printf "%s-tc-auth-usr-%s" (include "search-projector.fullname" .) "elastic" }}
{{- end }}
{{- end -}}
