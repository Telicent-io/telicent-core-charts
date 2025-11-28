{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version of oauth2-proxy
*/}}
{{- define "oauth2-proxy.version" -}}
{{ .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry of the oauth2-proxy
*/}}
{{- define "oauth2-proxy.imageRegistry" -}}
{{- .Values.image.registry }}
{{- end -}}

{{/*
Returns the image of search
*/}}
{{- define "oauth2-proxy.image" -}}
{{- printf "%s/%s:%s" (include "oauth2-proxy.imageRegistry" .) .Values.image.repository  (include "oauth2-proxy.version" .) }}
{{- end -}}
