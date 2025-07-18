{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "user-preferences-api.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "user-preferences-api.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image 
*/}}
{{- define "user-preferences-api.image" -}}
{{- printf "%s/%s:%s" (include "user-preferences-api.imageRegistry" .) .Values.image.repository  (include "user-preferences-api.version" .) }}
{{- end -}}
