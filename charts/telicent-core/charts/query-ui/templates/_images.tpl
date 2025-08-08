{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "query.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "query.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image 
*/}}
{{- define "query.image" -}}
{{- printf "%s/%s:%s" (include "query.imageRegistry" .) .Values.image.repository  (include "query.version" .) }}
{{- end -}}
