{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version of the search-projector
*/}}
{{- define "search-projector.version" -}}
{{ .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry of the search-projector
*/}}
{{- define "search-projector.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image of the search projector
*/}}
{{- define "search-projector.image" -}}
{{- printf "%s/%s:%s" (include "search-projector.imageRegistry" .) .Values.image.repository  (include "search-projector.version" .) }}
{{- end -}}
