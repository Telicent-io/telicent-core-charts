{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{- define "access-ui.ingressPrincipal" -}}
{{- .Values.istio.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.istio.ingress.serviceAccountName) | quote }}
{{- end }}
