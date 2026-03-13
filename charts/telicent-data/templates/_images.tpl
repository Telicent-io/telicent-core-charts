{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "telicent-data.version" -}}
{{- .image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "telicent-data.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "telicent-data.image" -}}
{{- printf "%s/%s:%s" (include "telicent-data.imageRegistry" .) .image.repository (include "telicent-data.version" .) }}
{{- end -}}
