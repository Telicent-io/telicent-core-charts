{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "user-portal-ui.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "user-portal-ui.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "user-portal-ui.image" -}}
{{- printf "%s/%s:%s" (include "user-portal-ui.imageRegistry" .) .Values.image.repository (include "user-portal-ui.version" .) }}
{{- end -}}
