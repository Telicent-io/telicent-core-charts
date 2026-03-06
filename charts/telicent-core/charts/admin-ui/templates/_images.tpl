{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "admin-ui.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "admin-ui.imageRegistry" -}}
{{- .Values.image.registry }}
{{- end -}}

{{/*
Returns the image 
*/}}
{{- define "admin-ui.image" -}}
{{- printf "%s/%s:%s" (include "admin-ui.imageRegistry" .) .Values.image.repository  (include "admin-ui.version" .) }}
{{- end -}}
