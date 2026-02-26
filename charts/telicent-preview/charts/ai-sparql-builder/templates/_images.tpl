{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "ai-sparql-builder.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "ai-sparql-builder.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "ai-sparql-builder.image" -}}
{{- printf "%s/%s:%s" (include "ai-sparql-builder.imageRegistry" .) .Values.image.repository  (include "ai-sparql-builder.version" .) }}
{{- end -}}
