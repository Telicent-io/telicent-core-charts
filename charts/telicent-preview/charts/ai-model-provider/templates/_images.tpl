{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "ai-model-provider.version" -}}
{{ .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "ai-model-provider.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "ai-model-provider.image" -}}
{{- printf "%s/%s:%s" (include "ai-model-provider.imageRegistry" .) .Values.image.repository  (include "ai-model-provider.version" .) }}
{{- end -}}
