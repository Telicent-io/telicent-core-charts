{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
This file contains the names of other host/service name(s) and service account name(s) on which this
application relies on. For a full explanation please view '_hosts.tlp' file in the 'auth' sub-chart.
*/}}

{{/* traefik-proxy | core - returns host ('service:port') and serviceAccount */}}
{{- define "ai-sparql-builder.hostTraefikProxy" -}}
{{- printf "%s" (include "common.discoverHostCore" (list . .Values.hostsCore.traefikProxy )) -}}
{{- end -}}
{{- define "ai-sparql-builder.serviceAccountTraefikProxy" -}}
{{- printf "%s" (include "common.discoverServiceAccountCore" (list . .Values.hostsCore.traefikProxy )) -}}
{{- end -}}

{{/* auth | core - returns host ('service:port') and serviceAccount */}}
{{- define "ai-sparql-builder.hostAuth" -}}
{{- printf "%s" (include "common.discoverHostCore" (list . .Values.hostsCore.auth )) -}}
{{- end -}}
{{- define "ai-sparql-builder.serviceAccountAuth" -}}
{{- printf "%s" (include "common.discoverServiceAccountCore" (list . .Values.hostsCore.auth )) -}}
{{- end -}}

{{/* graph | core - returns host ('service:port') and serviceAccount */}}
{{- define "ai-sparql-builder.hostGraph" -}}
{{- printf "%s" (include "common.discoverHostCore" (list . .Values.hostsCore.graph )) -}}
{{- end -}}
{{- define "ai-sparql-builder.serviceAccountGraph" -}}
{{- printf "%s" (include "common.discoverServiceAccountCore" (list . .Values.hostsCore.graph )) -}}
{{- end -}}
