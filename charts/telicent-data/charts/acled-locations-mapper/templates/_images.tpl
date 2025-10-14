{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "acled-locations-mapper.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "acled-locations-mapper.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "acled-locations-mapper.image" -}}
{{- printf "%s/%s:%s" (include "acled-locations-mapper.imageRegistry" .) .Values.image.repository (include "acled-locations-mapper.version" .) }}
{{- end -}}
