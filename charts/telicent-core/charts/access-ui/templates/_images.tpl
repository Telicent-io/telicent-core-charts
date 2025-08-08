{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "access-ui.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "access-ui.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image 
*/}}
{{- define "access-ui.image" -}}
{{- printf "%s/%s:%s" (include "access-ui.imageRegistry" .) .Values.image.repository  (include "access-ui.version" .) }}
{{- end -}}
