{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
This file contains the names of other host/service name(s) and service account name(s) on which this
application relies on. For a full explanation please view '_hosts.tlp' file in the 'auth' sub-chart.
*/}}

{{/* traefik-proxy | core - returns host ('service:port') and serviceAccount */}}
{{- define "paperback-writer.hostTraefikProxy" -}}
{{- printf "%s" (include "common.discoverHostCore" (list . .Values.hostsCore.traefikProxy )) -}}
{{- end -}}
{{- define "paperback-writer.serviceAccountTraefikProxy" -}}
{{- printf "%s" (include "common.discoverServiceAccountCore" (list . .Values.hostsCore.traefikProxy )) -}}
{{- end -}}

{{/* auth | core - returns host ('service:port') and serviceAccount */}}
{{- define "paperback-writer.hostAuth" -}}
{{- printf "%s" (include "common.discoverHostCore" (list . .Values.hostsCore.auth )) -}}
{{- end -}}
{{- define "paperback-writer.serviceAccountAuth" -}}
{{- printf "%s" (include "common.discoverServiceAccountCore" (list . .Values.hostsCore.auth )) -}}
{{- end -}}

{{/* graph | core - returns host ('service:port') and serviceAccount */}}
{{- define "paperback-writer.hostGraph" -}}
{{- printf "%s" (include "common.discoverHostCore" (list . .Values.hostsCore.graph )) -}}
{{- end -}}
{{- define "paperback-writer.serviceAccountGraph" -}}
{{- printf "%s" (include "common.discoverServiceAccountCore" (list . .Values.hostsCore.graph )) -}}
{{- end -}}
