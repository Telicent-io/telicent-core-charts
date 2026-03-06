{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "ontologies-rdf-rdfs-owl-producer.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "ontologies-rdf-rdfs-owl-producer.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "ontologies-rdf-rdfs-owl-producer.image" -}}
{{- printf "%s/%s:%s" (include "ontologies-rdf-rdfs-owl-producer.imageRegistry" .) .Values.image.repository (include "ontologies-rdf-rdfs-owl-producer.version" .) }}
{{- end -}}
