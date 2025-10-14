{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "producer-acled-ontology.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "producer-acled-ontology.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "producer-acled-ontology.image" -}}
{{- printf "%s/%s:%s" (include "producer-acled-ontology.imageRegistry" .) .Values.image.repository (include "producer-acled-ontology.version" .) }}
{{- end -}}
