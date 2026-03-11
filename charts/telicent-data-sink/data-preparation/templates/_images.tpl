{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "data-preparation.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "data-preparation.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "data-preparation.image" -}}
{{- printf "%s/%s:%s" (include "data-preparation.imageRegistry" .) .Values.image.repository  (include "data-preparation.version" .) }}
{{- end -}}
