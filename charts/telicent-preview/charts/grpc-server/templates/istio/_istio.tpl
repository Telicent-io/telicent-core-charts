{{/*
Copyright (C) Telicent Limited
*/}}

{{/*
Returns the principal used for GRPC Client traffic by the Istio AuthorizationPolicy
*/}}
{{- define "grpc-server.grpcClientPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "grpc-server.ser" .) -}}
{{- end -}}

{{/*
Returns the principal used for User Preferences traffic by the Istio AuthorizationPolicy
*/}}
{{- define "auth.userPreferencesPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "grpc-server.serviceAccountGrpcClient" .) -}}
{{- end -}}