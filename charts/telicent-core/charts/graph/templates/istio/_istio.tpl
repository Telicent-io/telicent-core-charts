{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{- define "graph.ingressPrincipal" -}}
{{- .Values.istio.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.istio.ingress.serviceAccountName) | quote }}
{{- end }}
