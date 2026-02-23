{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the principal used for Ingress traffic by telicent-ai-services by the Istio AuthorizationPolicy
*/}}
{{- define "ai-model-provider.aiServicesIngressPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "ai-model-provider.serviceAccountAIservices" .) -}}
{{- end -}}

{{/*
Returns the principal used for Ingress traffic by the Istio AuthorizationPolicy
*/}}
{{- define "ai-model-provider.ingressPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "ai-model-provider.serviceAccountTraefikProxy" .) -}}
{{- end -}}