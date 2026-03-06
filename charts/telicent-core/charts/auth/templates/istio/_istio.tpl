{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the principal used for Ingress traffic by the Istio AuthorizationPolicy
*/}}
{{- define "auth.ingressPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "auth.serviceAccountTraefikProxy" .) -}}
{{- end -}}

{{/*
Returns the principal used for User Preferences traffic by the Istio AuthorizationPolicy
*/}}
{{- define "auth.userPreferencesPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "auth.serviceAccountUserPreferences" .) -}}
{{- end -}}

{{/*
Returns the principal used for Graph traffic by the Istio AuthorizationPolicy
Note: Graph traffic is allowed in both OSS and Enterprise, it is only the Graph UI that is Enterprise-only
*/}}
{{- define "auth.graphPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "auth.serviceAccountGraph" .) -}}
{{- end -}}


{{/*
Returns the principal used for Search traffic by the Istio AuthorizationPolicy
*/}}
{{- define "auth.searchPrincipal" -}}
{{- if .Values.global.enterprise -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "auth.serviceAccountSearch" .) -}}
{{- end -}}
{{- end -}}

{{/*
Returns the principal used for Paperback Writer traffic by the Istio AuthorizationPolicy
*/}}
{{- define "auth.paperbackWriterPrincipal" -}}
{{- if .Values.global.enterprise -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "auth.serviceAccountPaperbackWriter" .) -}}
{{- end -}}
{{- end -}}

{{/*
Returns the principal used for Spatial traffic by the Istio AuthorizationPolicy
*/}}
{{- define "auth.spatialPrincipal" -}}
{{- if .Values.global.enterprise -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "auth.serviceAccountSpatial" .) -}}
{{- end -}}
{{- end -}}

{{/*
Returns the principal used for ai-sparql-builder traffic by the Istio AuthorizationPolicy
*/}}
{{- define "auth.aiSparqlBuilderPrincipal" -}}
{{- if .Values.global.enterprise -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "auth.serviceAccountAISparqlBuilder" .) -}}
{{- end -}}
{{- end -}}

{{/*
Returns the principal used for Notifications traffic by the Istio AuthorizationPolicy
*/}}
{{- define "auth.notificationsPrincipal" -}}
{{- if .Values.global.enterprise -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "auth.serviceAccountNotifications" .) -}}
{{- end -}}
{{- end -}}