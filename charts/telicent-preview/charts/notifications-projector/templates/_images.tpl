{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "notifications-projector.version" -}}
{{ .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "notifications-projector.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "notifications-projector.image" -}}
{{- printf "%s/%s:%s" (include "notifications-projector.imageRegistry" .) .Values.image.repository  (include "notifications-projector.version" .) }}
{{- end -}}
