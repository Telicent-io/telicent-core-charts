{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "data-catalog.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "data-catalog.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image 
*/}}
{{- define "data-catalog.image" -}}
{{- printf "%s/%s:%s" (include "data-catalog.imageRegistry" .) .Values.image.repository  (include "data-catalog.version" .) }}
{{- end -}}
