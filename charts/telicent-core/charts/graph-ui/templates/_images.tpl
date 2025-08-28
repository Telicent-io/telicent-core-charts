{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "graph-ui.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "graph-ui.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image 
*/}}
{{- define "graph-ui.image" -}}
{{- printf "%s/%s:%s" (include "graph-ui.imageRegistry" .) .Values.image.repository  (include "graph-ui.version" .) }}
{{- end -}}
