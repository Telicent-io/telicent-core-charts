{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{- define "data-catalog-ui.ingressPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "data-catalog-ui.serviceAccountTraefikProxy" .) -}}
{{- end }}
