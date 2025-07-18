{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "access-api.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "access-api.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}


{{/*
Returns the image 
*/}}
{{- define "access-api.image" -}}
{{-   printf "%s/%s:%s" (include "access-api.imageRegistry" .) .Values.image.repository  (include "access-api.version" .) }}
{{- end -}}
