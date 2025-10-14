{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "ies-regions-producer.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "ies-regions-producer.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "ies-regions-producer.image" -}}
{{- printf "%s/%s:%s" (include "ies-regions-producer.imageRegistry" .) .Values.image.repository (include "ies-regions-producer.version" .) }}
{{- end -}}
