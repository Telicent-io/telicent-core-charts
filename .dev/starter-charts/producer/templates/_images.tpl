{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "<CHARTNAME>.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "<CHARTNAME>.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "<CHARTNAME>.image" -}}
{{- printf "%s/%s:%s" (include "<CHARTNAME>.imageRegistry" .) .Values.image.repository (include "<CHARTNAME>.version" .) }}
{{- end -}}
