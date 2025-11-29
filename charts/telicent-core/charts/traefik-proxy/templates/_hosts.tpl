{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
This file contains the names of other host/service name(s) and service account name(s) on which this
application relies on. For a full explanation please view '_hosts.tlp' file in the 'auth' sub-chart.
*/}}

{{/* --------------------------- Start boiler plate ---------------------------
Note: Dev team - only the function prefix ("traefik-proxy.") and the references 
should be updated when copied into other sub-charts.
*/}}
{{/* Returns the service/serviceAccount with or without a release name */}}
{{- define "traefik-proxy.discoverService" -}}
{{- $envVal := index . 0 -}}
{{- $serviceVal := index . 1 -}}
{{- $name := default $envVal.Chart.Name $envVal.Values.nameOverride -}}
{{- if or (contains $name $envVal.Release.Name) (eq ($envVal.Values.hosts.enableAutoConfigure) false) -}}
{{- printf "%s" $serviceVal -}}
{{- else -}}
{{- printf "%s-%s" $envVal.Release.Name $serviceVal -}}
{{- end -}}
{{- end -}}
{{/* Returns the *host* ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.discoverHost" -}}
{{- $envVal := index . 0 -}}
{{- $hostVal := index . 1 -}}
{{- if $envVal.Values.hosts.enableAutoCorrect -}}
{{- $name := (index (splitList ":" $hostVal) 0 ) -}}
{{- $port := (index (splitList ":" $hostVal) 1 ) -}}
{{- printf "%s.%s:%s" (include "traefik-proxy.discoverService" (list $envVal $name)) $envVal.Release.Namespace $port -}}
{{- else -}}
{{- printf "%s" $hostVal -}}
{{- end -}}
{{- end -}}
{{- define "traefik-proxy.discoverServiceAccount" -}}
{{- $envVal := index . 0 -}}
{{- $hostVal := index . 1 -}}
{{- $name := (index (splitList ":" $hostVal) 0 ) -}}
{{- if $envVal.Values.hosts.enableAutoCorrect -}}
{{- printf "%s" (include "traefik-proxy.discoverService" (list $envVal $name)) -}}
{{- else -}}
{{- printf "%s" $name -}}
{{- end -}}
{{- end -}}
{{/* Returns the *preview host* ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.discoverHostPreview" -}}
{{- $envVal := index . 0 -}}
{{- $hostVal := index . 1 -}}
{{- $name := (index (splitList ":" $hostVal) 0 ) -}}
{{- $port := (index (splitList ":" $hostVal) 1 ) -}}
{{- if and $envVal.Values.hostsPreview.enableAutoCorrect $envVal.Values.global.releaseNameTelicentPreview -}}
{{- printf "%s-%s.%s:%s" $envVal.Values.global.releaseNameTelicentPreview $name $envVal.Release.Namespace $port -}}
{{- else -}}
{{- printf "%s.%s:%s" $name $envVal.Release.Namespace $port -}}
{{- end -}}
{{- end -}}
{{- define "traefik-proxy.discoverServiceAccountPreview" -}}
{{- $envVal := index . 0 -}}
{{- $hostVal := index . 1 -}}
{{- $name := (index (splitList ":" $hostVal) 0 ) -}}
{{- if and $envVal.Values.hostsPreview.enableAutoCorrect $envVal.Values.global.releaseNameTelicentPreview -}}
{{- printf "%s-%s" $envVal.Values.global.releaseNameTelicentPreview $name -}}
{{- else -}}
{{- printf "%s" $name -}}
{{- end -}}
{{- end -}}
{{/* ------------------------- End boiler plate ------------------------- */}}

{{/* auth - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostAuth" -}}
{{- printf "%s" (include "traefik-proxy.discoverHost" (list . .Values.hosts.auth )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountAuth" -}}
{{- printf "%s" (include "traefik-proxy.discoverServiceAccount" (list . .Values.hosts.auth )) -}}
{{- end -}}

{{/* user-preferences - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostUserPreferences" -}}
{{- printf "%s" (include "traefik-proxy.discoverHost" (list . .Values.hosts.userPreferences )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountUserPreferences" -}}
{{- printf "%s" (include "traefik-proxy.discoverServiceAccount" (list . .Values.hosts.userPreferences )) -}}
{{- end -}}

{{/* search - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostSearch" -}}
{{- printf "%s" (include "traefik-proxy.discoverHost" (list . .Values.hosts.search )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountSearch" -}}
{{- printf "%s" (include "traefik-proxy.discoverServiceAccount" (list . .Values.hosts.search )) -}}
{{- end -}}

{{/* graph - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostGraph" -}}
{{- printf "%s" (include "traefik-proxy.discoverHost" (list . .Values.hosts.graph )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountGraph" -}}
{{- printf "%s" (include "traefik-proxy.discoverServiceAccount" (list . .Values.hosts.graph )) -}}
{{- end -}}

{{/* admin-ui - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostAdminUi" -}}
{{- printf "%s" (include "traefik-proxy.discoverHost" (list . .Values.hosts.adminUi )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountAdminUi" -}}
{{- printf "%s" (include "traefik-proxy.discoverServiceAccount" (list . .Values.hosts.adminUi )) -}}
{{- end -}}

{{/* search-ui - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostSearchUi" -}}
{{- printf "%s" (include "traefik-proxy.discoverHost" (list . .Values.hosts.searchUi )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountSearchUi" -}}
{{- printf "%s" (include "traefik-proxy.discoverServiceAccount" (list . .Values.hosts.searchUi )) -}}
{{- end -}}

{{/* graph-ui - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostGraphUi" -}}
{{- printf "%s" (include "traefik-proxy.discoverHost" (list . .Values.hosts.graphUi )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountGraphUi" -}}
{{- printf "%s" (include "traefik-proxy.discoverServiceAccount" (list . .Values.hosts.graphUi )) -}}
{{- end -}}

{{/* query-ui - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostQueryUi" -}}
{{- printf "%s" (include "traefik-proxy.discoverHost" (list . .Values.hosts.queryUi )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountQueryUi" -}}
{{- printf "%s" (include "traefik-proxy.discoverServiceAccount" (list . .Values.hosts.queryUi )) -}}
{{- end -}}

{{/* user-portal-ui | preview - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostUserPortalUi" -}}
{{- printf "%s" (include "traefik-proxy.discoverHostPreview" (list . .Values.hostsPreview.userPortalUi )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountUserPortalUi" -}}
{{- printf "%s" (include "traefik-proxy.discoverServiceAccountPreview" (list . .Values.hostsPreview.userPortalUi )) -}}
{{- end -}}

{{/* data-catalog-ui | preview - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostDataCatalogUi" -}}
{{- printf "%s" (include "traefik-proxy.discoverHostPreview" (list . .Values.hostsPreview.dataCatalogUi )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountDataCatalogUi" -}}
{{- printf "%s" (include "traefik-proxy.discoverServiceAccountPreview" (list . .Values.hostsPreview.dataCatalogUi )) -}}
{{- end -}}

{{/* paperback-writer | preview - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostPaperbackWriter" -}}
{{- printf "%s" (include "traefik-proxy.discoverHostPreview" (list . .Values.hostsPreview.paperbackWriter )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountPaperbackWriter" -}}
{{- printf "%s" (include "traefik-proxy.discoverServiceAccountPaperbackWriter" (list . .Values.hostsPreview.paperbackWriter )) -}}
{{- end -}}
