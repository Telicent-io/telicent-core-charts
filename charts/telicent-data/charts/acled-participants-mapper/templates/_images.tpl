{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "acled-participants-mapper.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "acled-participants-mapper.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "acled-participants-mapper.image" -}}
{{- printf "%s/%s:%s" (include "acled-participants-mapper.imageRegistry" .) .Values.image.repository (include "acled-participants-mapper.version" .) }}
{{- end -}}
