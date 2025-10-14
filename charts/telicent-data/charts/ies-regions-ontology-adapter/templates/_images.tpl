{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "ies-regions-ontology-adapter.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "ies-regions-ontology-adapter.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "ies-regions-ontology-adapter.image" -}}
{{- printf "%s/%s:%s" (include "ies-regions-ontology-adapter.imageRegistry" .) .Values.image.repository (include "ies-regions-ontology-adapter.version" .) }}
{{- end -}}
