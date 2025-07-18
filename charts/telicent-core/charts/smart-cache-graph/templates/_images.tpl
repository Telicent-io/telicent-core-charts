{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "smart-cache-graph.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "smart-cache-graph.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image 
*/}}
{{- define "smart-cache-graph.image" -}}
{{- printf "%s/%s:%s" (include "smart-cache-graph.imageRegistry" .) .Values.image.repository  (include "smart-cache-graph.version" .) }}
{{- end -}}
