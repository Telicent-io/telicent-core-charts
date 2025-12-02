{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "content-extractor.version" -}}
{{ .Values.contentExtractor.image.tag }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "content-extractor.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.contentExtractor.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "content-extractor.image" -}}
{{- printf "%s/%s:%s" (include "content-extractor.imageRegistry" .) .Values.contentExtractor.image.repository  (include "content-extractor.version" .) }}
{{- end -}}
