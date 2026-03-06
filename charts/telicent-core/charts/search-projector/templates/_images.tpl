{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "search-projector.version" -}}
{{ .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "search-projector.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "search-projector.image" -}}
{{- printf "%s/%s:%s" (include "search-projector.imageRegistry" .) .Values.image.repository  (include "search-projector.version" .) }}
{{- end -}}
