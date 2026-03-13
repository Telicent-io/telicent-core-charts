{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the principal used for istio traffic by the Istio AuthorizationPolicy
*/}}
{{- define "grpc-server.istioPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" (include "istio.ingressNamespace" .) (include "istio.ingressServiceAccount" .) }}
{{- end }}
