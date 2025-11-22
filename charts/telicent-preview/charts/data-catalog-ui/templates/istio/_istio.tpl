{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{- define "data-catalog-ui.ingressPrincipal" -}}
{{- .Values.istio.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Values.global.istioNamespace .Values.global.istioServiceAccountName) | quote }}
{{- end }}
