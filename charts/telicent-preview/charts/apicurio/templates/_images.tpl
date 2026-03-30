{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "apicurio.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "apicurio.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "apicurio.image" -}}
{{- printf "%s/%s:%s" (include "apicurio.imageRegistry" .) .Values.image.repository (include "apicurio.version" .) }}
{{- end -}}