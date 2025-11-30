{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
This file contains the names of other host/service(s) and serviceAccount(s) on which this
application relies on. They are defined here and referenced in resources such as config maps and istio.

The default behaviour when installing through the parent chart 'telicent-core' is the releasename
being prefixed to all sub-chart resources.
Example: naming a release 'core', will result in 'core-auth-*' resources being generated.
The helpers functions in this file is used to update those references accordingly.

To allow for short name resources across all applications, when installing through the parent chart:
Set 'fullnameOverride' equivalent to the sub-cart name and 'hosts.enableAutoCorrect: false' on all sub-charts.
Doing so will correctly configure the whole system.
*/}}

{{/*
Detailed description of 'discoverHost' & 'discoverServiceAccount' function
1.a) Installed through the parent chart, the service name will include the release name.
1.b) Installed through the parent chart, where 'hosts.enableAutoCorrect: false' has been set on the sub-chart.
     Will result in the release name *not* being included.
2.)  Installed through a sub chart, where the release name is set to 'auth' (identical to the chart name).
     The release name will *not* be included.
*/}}

{{/* traefik-proxy - returns host ('service:port') and serviceAccount */}}
{{- define "auth.hostTraefikProxy" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.traefikProxy )) -}}
{{- end -}}
{{- define "auth.serviceAccountTraefikProxy" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.traefikProxy )) -}}
{{- end -}}

{{/* user-preferences - returns host ('service:port') and serviceAccount */}}
{{- define "auth.hostUserPreferences" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.userPreferences )) -}}
{{- end -}}
{{- define "auth.serviceAccountUserPreferences" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.userPreferences )) -}}
{{- end -}}

{{/* search - returns host ('service:port') and serviceAccount */}}
{{- define "auth.hostSearch" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.search )) -}}
{{- end -}}
{{- define "auth.serviceAccountSearch" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.search )) -}}
{{- end -}}

{{/* graph - returns host ('service:port') and serviceAccount */}}
{{- define "auth.hostGraph" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.graph )) -}}
{{- end -}}
{{- define "auth.serviceAccountGraph" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.graph )) -}}
{{- end -}}

{{/* paperback-writer | preview - returns host ('service:port') and serviceAccount */}}
{{- define "auth.hostPaperbackWriter" -}}
{{- printf "%s" (include "common.discoverHostPreview" (list . .Values.hostsPreview.paperbackWriter )) -}}
{{- end -}}
{{- define "auth.serviceAccountPaperbackWriter" -}}
{{- printf "%s" (include "common.discoverServiceAccountPreview" (list . .Values.hostsPreview.paperbackWriter )) -}}
{{- end -}}
