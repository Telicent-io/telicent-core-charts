{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the principal used for Ingress traffic by the Istio AuthorizationPolicy
*/}}
{{- define "graph.ingressPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "graph.serviceAccountTraefikProxy" .) -}}
{{- end -}}

{{/*
Returns the principal used for Paperback Writer traffic by the Istio AuthorizationPolicy
*/}}
{{- define "graph.paperbackWriterPrincipal" -}}
{{- if .Values.global.enterprise -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "graph.serviceAccountPaperbackWriter" .) -}}
{{- end -}}
{{- end -}}
