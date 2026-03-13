{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
This file contains the names of other host/service name(s) and service account name(s) on which this
application relies on. For a full explanation please view '_hosts.tlp' file in the 'auth' sub-chart.
*/}}

{{/* traefik-proxy | core - returns host ('service:port') and serviceAccount */}}
{{- define "notifications.hostTraefikProxy" -}}
{{- printf "%s" (include "common.discoverHostCore" (list . .Values.hostsCore.traefikProxy )) -}}
{{- end -}}
{{- define "notifications.serviceAccountTraefikProxy" -}}
{{- printf "%s" (include "common.discoverServiceAccountCore" (list . .Values.hostsCore.traefikProxy )) -}}
{{- end -}}

{{/* auth | core - returns host ('service:port') and serviceAccount */}}
{{- define "notifications.hostAuth" -}}
{{- printf "%s" (include "common.discoverHostCore" (list . .Values.hostsCore.auth )) -}}
{{- end -}}
{{- define "notifications.serviceAccountAuth" -}}
{{- printf "%s" (include "common.discoverServiceAccountCore" (list . .Values.hostsCore.auth )) -}}
{{- end -}}
