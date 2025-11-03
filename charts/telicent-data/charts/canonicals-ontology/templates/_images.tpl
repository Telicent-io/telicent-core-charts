{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "canonicals-ontology-mapper.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "canonicals-ontology-mapper.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "canonicals-ontology-mapper.image" -}}
{{- printf "%s/%s:%s" (include "canonicals-ontology-mapper.imageRegistry" .) .Values.image.mapperRepository (include "canonicals-ontology-mapper.version" .) }}
{{- end -}}


{{/*
Returns the version
*/}}
{{- define "canonicals-ontology-validation-mapper.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "canonicals-ontology-validation-mapper.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "canonicals-ontology-validation-mapper.image" -}}
{{- printf "%s/%s:%s" (include "canonicals-ontology-validation-mapper.imageRegistry" .) .Values.image.validationRepository (include "canonicals-ontology-validation-mapper.version" .) }}
{{- end -}}
