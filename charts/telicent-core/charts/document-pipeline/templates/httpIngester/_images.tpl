{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "http-ingester.version" -}}
{{ .Values.httpIngester.image.tag }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "http-ingester.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.httpIngester.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "http-ingester.image" -}}
{{- printf "%s/%s:%s" (include "http-ingester.imageRegistry" .) .Values.httpIngester.image.repository  (include "http-ingester.version" .) }}
{{- end -}}
