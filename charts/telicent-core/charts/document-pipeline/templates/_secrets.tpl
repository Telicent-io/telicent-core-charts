{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the elastic / opensearch secret
*/}}
{{- define "content-indexer.elasticSecretName" -}}
{{- if .Values.contentIndexer.elasticSecret.existingSecret }}
{{- .Values.contentIndexer.elasticSecret.existingSecret }}
{{- else }}
{{- printf "%s-tc-auth-usr-%s" (include "content-indexer.fullname" .) "elastic" }}
{{- end }}
{{- end -}}
