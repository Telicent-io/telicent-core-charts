{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "traefik-proxy.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "traefik-proxy.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image 
*/}}
{{- define "traefik-proxy.image" -}}
{{- printf "%s/%s:%s" (include "traefik-proxy.imageRegistry" .) .Values.image.repository  (include "traefik-proxy.version" .) }}
{{- end -}}
