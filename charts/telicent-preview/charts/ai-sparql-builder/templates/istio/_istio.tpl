{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the principal used for Ingress traffic by the Istio AuthorizationPolicy
*/}}
{{- define "ai-sparql-builder.ingressPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "ai-sparql-builder.serviceAccountTraefikProxy" .) -}}
{{- end }}
