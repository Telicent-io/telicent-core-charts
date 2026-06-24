{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
This file contains the names of other host/service name(s) and service account name(s) on which this
application relies on. For a full explanation please view '_hosts.tlp' file in the 'auth' sub-chart.
*/}}

{{/* auth - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostAuth" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.auth )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountAuth" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.auth )) -}}
{{- end -}}

{{/* user-preferences - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostUserPreferences" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.userPreferences )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountUserPreferences" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.userPreferences )) -}}
{{- end -}}

{{/* search - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostSearch" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.search )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountSearch" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.search )) -}}
{{- end -}}

{{/* graph - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostGraph" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.graph )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountGraph" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.graph )) -}}
{{- end -}}

{{/* admin-ui - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostAdminUi" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.adminUi )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountAdminUi" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.adminUi )) -}}
{{- end -}}

{{/* search-ui - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostSearchUi" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.searchUi )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountSearchUi" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.searchUi )) -}}
{{- end -}}

{{/* graph-ui - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostGraphUi" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.graphUi )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountGraphUi" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.graphUi )) -}}
{{- end -}}

{{/* query-ui - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostQueryUi" -}}
{{- printf "%s" (include "common.discoverHost" (list . .Values.hosts.queryUi )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountQueryUi" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.queryUi )) -}}
{{- end -}}

{{/* user-portal-ui | preview - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostUserPortalUi" -}}
{{- printf "%s" (include "common.discoverHostPreview" (list . .Values.hostsPreview.userPortalUi )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountUserPortalUi" -}}
{{- printf "%s" (include "common.discoverServiceAccountPreview" (list . .Values.hostsPreview.userPortalUi )) -}}
{{- end -}}

{{/* data-catalog-ui | preview - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostDataCatalogUi" -}}
{{- printf "%s" (include "common.discoverHostPreview" (list . .Values.hostsPreview.dataCatalogUi )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountDataCatalogUi" -}}
{{- printf "%s" (include "common.discoverServiceAccountPreview" (list . .Values.hostsPreview.dataCatalogUi )) -}}
{{- end -}}

{{/* catalogue | preview - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostCatalogue" -}}
{{- printf "%s" (include "common.discoverHostPreview" (list . .Values.hostsPreview.catalogue )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountCatalogue" -}}
{{- printf "%s" (include "common.discoverServiceAccountPreview" (list . .Values.hostsPreview.catalogue )) -}}
{{- end -}}

{{/* paperback-writer | preview - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostPaperbackWriter" -}}
{{- printf "%s" (include "common.discoverHostPreview" (list . .Values.hostsPreview.paperbackWriter )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountPaperbackWriter" -}}
{{- printf "%s" (include "common.discoverServiceAccountPreview" (list . .Values.hostsPreview.paperbackWriter )) -}}
{{- end -}}

{{/* ai-sparql-builder | preview - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostAISparqlBuilder" -}}
{{- printf "%s" (include "common.discoverHostPreview" (list . .Values.hostsPreview.aiSparqlBuilder )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountAISparqlBuilder" -}}
{{- printf "%s" (include "common.discoverServiceAccountPreview" (list . .Values.hostsPreview.aiSparqlBuilder )) -}}
{{- end -}}

{{/* notifications | preview - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostNotifications" -}}
{{- printf "%s" (include "common.discoverHostPreview" (list . .Values.hostsPreview.notifications )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountNotifications" -}}
{{- printf "%s" (include "common.discoverServiceAccountPreview" (list . .Values.hostsPreview.notifications )) -}}
{{- end -}}

{{/* apicurio | preview - returns host ('service:port') and serviceAccount */}}
{{- define "traefik-proxy.hostApicurio" -}}
{{- printf "%s" (include "common.discoverHostPreview" (list . .Values.hostsPreview.apicurio )) -}}
{{- end -}}
{{- define "traefik-proxy.serviceAccountApicurio" -}}
{{- printf "%s" (include "common.discoverServiceAccountPreview" (list . .Values.hostsPreview.apicurio )) -}}
{{- end -}}
