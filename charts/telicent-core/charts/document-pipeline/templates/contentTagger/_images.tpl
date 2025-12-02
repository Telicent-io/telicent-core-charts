{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "content-tagger.version" -}}
{{ .Values.contentTagger.image.tag }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "content-tagger.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.contentTagger.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "content-tagger.image" -}}
{{- printf "%s/%s:%s" (include "content-tagger.imageRegistry" .) .Values.contentTagger.image.repository  (include "content-tagger.version" .) }}
{{- end -}}
