{{/*
Copyright (C) Telicent Limited
*/}}

{{/*
Returns the principal used for GRPC Server traffic by the Istio AuthorizationPolicy
*/}}
{{- define "grpc-server.grpcClientPrincipal" -}}
{{- if .Values.global.enterprise -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "grpc-server.serviceAccountPaperbackWriter" .) -}}
{{- end -}}
{{- end -}}
