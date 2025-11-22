{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "data-catalog-ui.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "data-catalog-ui.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image 
*/}}
{{- define "data-catalog-ui.image" -}}
{{- printf "%s/%s:%s" (include "data-catalog-ui.imageRegistry" .) .Values.image.repository  (include "data-catalog-ui.version" .) }}
{{- end -}}
