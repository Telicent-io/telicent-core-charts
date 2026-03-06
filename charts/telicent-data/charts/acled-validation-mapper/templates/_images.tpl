{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "acled-validation-mapper.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "acled-validation-mapper.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "acled-validation-mapper.image" -}}
{{- printf "%s/%s:%s" (include "acled-validation-mapper.imageRegistry" .) .Values.image.repository (include "acled-validation-mapper.version" .) }}
{{- end -}}
