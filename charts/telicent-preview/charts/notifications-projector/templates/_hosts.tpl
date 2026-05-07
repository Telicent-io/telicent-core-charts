{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
This file contains the names of other host/service name(s) and service account name(s) on which this
application relies on. For a full explanation please view '_hosts.tlp' file in the 'auth' sub-chart.
*/}}

{{/* auth | core - returns host ('service:port') and serviceAccount */}}
{{- define "notifications-projector.hostAuth" -}}
{{- printf "%s" (include "common.discoverHostCore" (list . .Values.hostsCore.auth )) -}}
{{- end -}}
