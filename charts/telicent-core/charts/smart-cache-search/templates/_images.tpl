{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version of the api
*/}}
{{- define "smart-cache-search-api.version" -}}
{{ .Values.api.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the version of the projector
*/}}
{{- define "smart-cache-search-projector.version" -}}
{{ .Values.projector.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry of the api
*/}}
{{- define "smart-cache-search-api.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.api.image.registry }}
{{- end -}}

{{/*
Returns the image registry of the projector
*/}}
{{- define "smart-cache-search-projector.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.projector.image.registry }}
{{- end -}}

{{/*
Returns the image of the api
*/}}
{{- define "smart-cache-search-api.image" -}}
{{- printf "%s/%s:%s" (include "smart-cache-search-api.imageRegistry" .) .Values.api.image.repository  (include "smart-cache-search-api.version" .) }}
{{- end -}}

{{/*
Returns the image of the projector
*/}}
{{- define "smart-cache-search-projector.image" -}}
{{- printf "%s/%s:%s" (include "smart-cache-search-projector.imageRegistry" .) .Values.projector.image.repository  (include "smart-cache-search-projector.version" .) }}
{{- end -}}
