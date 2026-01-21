{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the principal used for istio traffic by the Istio AuthorizationPolicy
*/}}
{{- define "traefik-proxy.istioPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" (include "istio.ingressNamespace" .) (include "istio.ingressServiceAccount" .) }}
{{- end }}
