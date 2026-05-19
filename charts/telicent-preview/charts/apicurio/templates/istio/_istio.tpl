{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the principal used for Ingress traffic by the Istio AuthorizationPolicy
*/}}
{{- define "apicurio.ingressPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "apicurio.serviceAccountTraefikProxy" .) -}}
{{- end }}

{{/*
Returns the principal used for Notifications traffic by the Istio AuthorizationPolicy
*/}}
{{- define "apicurio.notificationsPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "apicurio.serviceAccountNotifications" .) -}}
{{- end }}
