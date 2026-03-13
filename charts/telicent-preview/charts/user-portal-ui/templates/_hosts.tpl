{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
This file contains the names of other host/service name(s) and service account name(s) on which this
application relies on. For a full explanation please view '_hosts.tlp' file in the 'auth' sub-chart.
*/}}

{{/* traefik-proxy | core - returns host ('service:port') and serviceAccount */}}
{{- define "user-portal-ui.hostTraefikProxy" -}}
{{- printf "%s" (include "common.discoverHostCore" (list . .Values.hostsCore.traefikProxy )) -}}
{{- end -}}
{{- define "user-portal-ui.serviceAccountTraefikProxy" -}}
{{- printf "%s" (include "common.discoverServiceAccountCore" (list . .Values.hostsCore.traefikProxy )) -}}
{{- end -}}

{{/* auth | core - returns host ('service:port') and serviceAccount */}}
{{- define "user-portal-ui.hostAuth" -}}
{{- printf "%s" (include "common.discoverHostCore" (list . .Values.hostsCore.auth )) -}}
{{- end -}}
{{- define "user-portal-ui.serviceAccountAuth" -}}
{{- printf "%s" (include "common.discoverServiceAccountCore" (list . .Values.hostsCore.auth )) -}}
{{- end -}}
