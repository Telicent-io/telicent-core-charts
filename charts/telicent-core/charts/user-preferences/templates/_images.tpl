{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "user-preferences.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "user-preferences.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image 
*/}}
{{- define "user-preferences.image" -}}
{{- printf "%s/%s:%s" (include "user-preferences.imageRegistry" .) .Values.image.repository  (include "user-preferences.version" .) }}
{{- end -}}
