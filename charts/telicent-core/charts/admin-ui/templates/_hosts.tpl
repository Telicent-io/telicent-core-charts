{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/* traefik-proxy - returns host ('service:port') and serviceAccount */}}
{{- define "admin-ui.hostTraefikProxy" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.traefikProxy )) -}}
{{- end -}}
{{- define "admin-ui.serviceAccountTraefikProxy" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.traefikProxy )) -}}
{{- end -}}
