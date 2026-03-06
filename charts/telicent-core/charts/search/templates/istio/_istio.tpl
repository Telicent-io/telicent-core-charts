{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the principal used for Ingress traffic by the Istio AuthorizationPolicy
*/}}
{{- define "search.ingressPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "search.serviceAccountTraefikProxy" .) -}}
{{- end -}}

{{/*
Returns the principal used for Graph traffic by the Istio AuthorizationPolicy
*/}}
{{- define "search.graphPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "search.serviceAccountGraph" .) -}}
{{- end -}}
