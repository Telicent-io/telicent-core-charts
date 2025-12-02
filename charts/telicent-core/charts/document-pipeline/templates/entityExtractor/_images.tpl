{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "entity-extractor.version" -}}
{{ .Values.entityExtractor.image.tag }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "entity-extractor.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.entityExtractor.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "entity-extractor.image" -}}
{{- printf "%s/%s:%s" (include "entity-extractor.imageRegistry" .) .Values.entityExtractor.image.repository  (include "entity-extractor.version" .) }}
{{- end -}}
