{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the elastic / opensearch secret
*/}}
{{- define "contentIndexer.elasticSecretName" -}}
{{- if .Values.contentIndexer.elasticSecret.existingSecret }}
{{- .Values.contentIndexer.elasticSecret.existingSecret }}
{{- else }}
{{- printf "tc-auth-usr-%s-%s" "elastic" (include "content-indexer.name" .) }}
{{- end }}
{{- end -}}
