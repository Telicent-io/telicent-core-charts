{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Create the name of the elastic / opensearch secret
*/}}
{{- define "contentIndexer.elasticSecretName" -}}
{{- if .Values.contentIndexer.elastic.existingSecret }}
{{- .Values.contentIndexer.elastic.existingSecret }}
{{- else }}
{{- printf "tc-auth-usr-%s-%s" "elastic" (include "content-indexer.name" .) }}
{{- end }}
{{- end -}}
