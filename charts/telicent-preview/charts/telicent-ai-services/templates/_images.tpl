{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "telicent-ai-services.version" -}}
{{ .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "telicent-ai-services.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "telicent-ai-services.image" -}}
{{- printf "%s/%s:%s" (include "telicent-ai-services.imageRegistry" .) .Values.image.repository  (include "telicent-ai-services.version" .) }}
{{- end -}}
