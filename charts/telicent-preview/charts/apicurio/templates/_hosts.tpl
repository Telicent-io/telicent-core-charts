{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
This file contains the names of other host/service name(s) and service account name(s) on which this
application relies on. For a full explanation please view '_hosts.tlp' file in the 'auth' sub-chart.
*/}}

{{/* auth - returns host ('service:port') and serviceAccount */}}
{{- define "apicurio.hostAuth" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hostsCore.auth )) -}}
{{- end -}}

{{/* traefik-proxy | core - returns host ('service:port') and serviceAccount */}}
{{- define "apicurio.hostTraefikProxy" -}}
{{- printf "%s" (include "common.discoverHostCore" (list . .Values.hostsCore.traefikProxy )) -}}
{{- end -}}
{{- define "apicurio.serviceAccountTraefikProxy" -}}
{{- printf "%s" (include "common.discoverServiceAccountCore" (list . .Values.hostsCore.traefikProxy )) -}}
{{- end -}}

{{/* notifications | preview - returns serviceAccount */}}
{{- define "apicurio.serviceAccountNotifications" -}}
{{- printf "%s" (include "common.discoverServiceAccountPreview" (list . .Values.hostsPreview.notifications )) -}}
{{- end -}}

{{/* notifications-projector | preview - returns serviceAccount */}}
{{- define "apicurio.serviceAccountNotificationsProjector" -}}
{{- printf "%s" (include "common.discoverServiceAccountPreview" (list . .Values.hostsPreview.notificationsProjector )) -}}
{{- end -}}
