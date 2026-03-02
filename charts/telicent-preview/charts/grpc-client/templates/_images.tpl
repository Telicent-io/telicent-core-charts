{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "grpc-client.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "grpc-client.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "grpc-client.image" -}}
{{- printf "%s/%s:%s" (include "grpc-client.imageRegistry" .) .Values.image.repository  (include "grpc-client.version" .) }}
{{- end -}}
