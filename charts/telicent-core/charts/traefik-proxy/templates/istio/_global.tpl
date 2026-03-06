{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns istio ingress namespace
*/}}
{{- define "istio.ingressNamespace" -}}
{{- .Values.global.istioIngressNamespace | default .Values.istio.ingress.namespace }}
{{- end -}}

{{/*
Returns istio ingress serviceAccount
*/}}
{{- define "istio.ingressServiceAccount" -}}
{{- .Values.global.istioIngressServiceAccount | default .Values.istio.ingress.serviceAccount }}
{{- end -}}

{{/*
Returns istio gateway namespace
*/}}
{{- define "istio.gatewayNamespace" -}}
{{- .Values.global.istioGatewayNamespace | default .Values.istio.gateway.namespace }}
{{- end -}}

{{/*
Returns istio gateway name
*/}}
{{- define "istio.gatewayName" -}}
{{- .Values.global.istioGatewayName | default .Values.istio.gateway.name }}
{{- end -}}
