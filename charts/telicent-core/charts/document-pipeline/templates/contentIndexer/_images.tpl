{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "content-indexer.version" -}}
{{ .Values.contentIndexer.image.tag }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "content-indexer.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.contentIndexer.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "content-indexer.image" -}}
{{- printf "%s/%s:%s" (include "content-indexer.imageRegistry" .) .Values.contentIndexer.image.repository  (include "content-indexer.version" .) }}
{{- end -}}
