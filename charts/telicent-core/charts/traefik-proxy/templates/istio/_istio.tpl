{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the principal used for traefik traffic by the Istio AuthorizationPolicy
*/}}
{{- define "traefik-proxy.ingressPrincipal" -}}
{{- .Values.istio.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.global.istioServiceAccountName) | quote }}
{{- end }}

