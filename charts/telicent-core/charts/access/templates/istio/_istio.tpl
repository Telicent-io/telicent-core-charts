{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the principal used for Ingress traffic by the Istio AuthorizationPolicy
*/}}
{{- define "access.ingressPrincipal" -}}
{{- .Values.istio.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.istio.ingress.serviceAccountName) | quote }}
{{- end }}

{{/*
Returns the principal used for Graph traffic by the Istio AuthorizationPolicy
*/}}
{{- define "access.graphPrincipal" -}}
{{- .Values.istio.graph.principal | default (printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.istio.graph.serviceAccountName) | quote }}
{{- end }}

{{/*
Returns the principal used for Search traffic by the Istio AuthorizationPolicy
*/}}
{{- define "access.searchPrincipal" -}}
{{- .Values.istio.search.principal | default (printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.istio.search.serviceAccountName) | quote }}
{{- end }}

{{/*
Returns the principal used for Paperback Writer traffic by the Istio AuthorizationPolicy
*/}}
{{- define "access.paperbackWriterPrincipal" -}}
{{- index .Values "istio" "paperback-writer" "principal" | default (printf "cluster.local/ns/%s/sa/%s" .Values.configuration.telicentPreviewReleaseName (index .Values "istio" "paperback-writer" "serviceAccountName")) | quote }}
{{- end }}
