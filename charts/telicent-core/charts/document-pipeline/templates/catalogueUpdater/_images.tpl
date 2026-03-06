{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "catalogue-updater.version" -}}
{{ .Values.catalogueUpdater.image.tag }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "catalogue-updater.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.catalogueUpdater.image.registry }}
{{- end -}}

{{/*
Returns the image
*/}}
{{- define "catalogue-updater.image" -}}
{{- printf "%s/%s:%s" (include "catalogue-updater.imageRegistry" .) .Values.catalogueUpdater.image.repository  (include "catalogue-updater.version" .) }}
{{- end -}}
