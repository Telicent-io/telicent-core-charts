{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version of search
*/}}
{{- define "search.version" -}}
{{ .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry of the search
*/}}
{{- define "search.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image of search
*/}}
{{- define "search.image" -}}
{{- printf "%s/%s:%s" (include "search.imageRegistry" .) .Values.image.repository  (include "search.version" .) }}
{{- end -}}
