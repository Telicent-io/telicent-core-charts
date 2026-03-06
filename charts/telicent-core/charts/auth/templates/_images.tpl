{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "auth.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "auth.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image 
*/}}
{{- define "auth.image" -}}
{{- printf "%s/%s:%s" (include "auth.imageRegistry" .) .Values.image.repository  (include "auth.version" .) }}
{{- end -}}
