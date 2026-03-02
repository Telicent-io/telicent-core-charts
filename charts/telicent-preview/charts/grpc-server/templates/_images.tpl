{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "grpc-server.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "grpc-server.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "grpc-server.image" -}}
{{- printf "%s/%s:%s" (include "grpc-server.imageRegistry" .) .Values.image.repository  (include "grpc-server.version" .) }}
{{- end -}}
