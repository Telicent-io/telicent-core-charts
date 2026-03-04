{{/*
Copyright (C) Telicent Limited
*/}}

{{/*
This file contains the names of other host/service name(s) and service account name(s) on which this
application relies on. For a full explanation please view '_hosts.tlp' file in the 'auth' sub-chart.
*/}}

{{/* grpc-client | preview - returns host ('service:port') and serviceAccount */}}
{{- define "grpc-server.grpcClienttAuth" -}}
{{- printf "%s" (include "common.discoverHostPreview" (list . .Values.hosts.grpcClient )) -}}
{{- end -}}
{{- define "grpc-server.serviceAccountGrpcClient" -}}
{{- printf "%s" (include "common.discoverServiceAccount" (list . .Values.hosts.grpcClient )) -}}
{{- end -}}
