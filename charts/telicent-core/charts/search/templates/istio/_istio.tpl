{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{- define "search.ingressPrincipal" -}}
{{- .Values.istio.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.istio.ingress.serviceAccountName) | quote }}
{{- end }}

{{- define "search.graphPrincipal" -}}
{{- .Values.istio.graph.principal | default (printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.istio.graph.serviceAccountName ) | quote }}
{{- end }}

