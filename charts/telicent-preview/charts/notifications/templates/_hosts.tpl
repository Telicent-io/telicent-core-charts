{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
This file contains the names of other host/service name(s) and service account name(s) on which this
application relies on. For a full explanation please view '_hosts.tlp' file in the 'auth' sub-chart.
*/}}


{{/* auth - returns host ('service:port') and serviceAccount */}}
{{- define "notifications.hostAuth" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.auth )) -}}
{{- end -}}
{{- define "notifications.serviceAccountAuth" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.auth )) -}}
{{- end -}}

{{/* traefik-proxy - returns host ('service:port') and serviceAccount */}}
{{- define "notifications.hostTraefikProxy" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.traefikProxy )) -}}
{{- end -}}
{{- define "notifications.serviceAccountTraefikProxy" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.traefikProxy )) -}}
{{- end -}}


