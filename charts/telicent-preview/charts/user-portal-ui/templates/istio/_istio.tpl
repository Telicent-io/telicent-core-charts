{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{- define "user-portal-ui.ingressPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "user-portal-ui.serviceAccountTraefikProxy" .) -}}
{{- end }}
