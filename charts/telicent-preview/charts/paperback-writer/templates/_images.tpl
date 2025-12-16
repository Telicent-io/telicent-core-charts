{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "paperback-writer.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "paperback-writer.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "paperback-writer.image" -}}
{{- printf "%s/%s:%s" (include "paperback-writer.imageRegistry" .) .Values.image.repository  (include "paperback-writer.version" .) }}
{{- end -}}
