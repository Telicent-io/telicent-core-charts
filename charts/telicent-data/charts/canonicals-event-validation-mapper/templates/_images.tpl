{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "canonicals-event-validation-mapper.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "canonicals-event-validation-mapper.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "canonicals-event-validation-mapper.image" -}}
{{- printf "%s/%s:%s" (include "canonicals-event-validation-mapper.imageRegistry" .) .Values.image.repository (include "canonicals-event-validation-mapper.version" .) }}
{{- end -}}
