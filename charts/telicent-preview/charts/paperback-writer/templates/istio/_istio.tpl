{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the principal used for Ingress traffic by the Istio AuthorizationPolicy
*/}}
{{- define "paperback-writer.ingressPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "paperback-writer.serviceAccountTraefikProxy" .) -}}
{{- end }}
