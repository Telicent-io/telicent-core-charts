{{/*
Copyright (C) Telicent Limited
*/}}

{{/*
Returns the principal used for GRPC Client traffic by the Istio AuthorizationPolicy
*/}}
{{- define "grpc-server.clientPrincipal" -}}
{{- if .Values.global.enterprise -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "graph.serviceAccountPaperbackWriter" .) -}}
{{- end -}}
{{- end -}}
