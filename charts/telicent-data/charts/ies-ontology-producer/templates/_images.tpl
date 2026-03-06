{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "ies-ontology-producer.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "ies-ontology-producer.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "ies-ontology-producer.image" -}}
{{- printf "%s/%s:%s" (include "ies-ontology-producer.imageRegistry" .) .Values.image.repository (include "ies-ontology-producer.version" .) }}
{{- end -}}
