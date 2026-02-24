{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the principal used for Ingress traffic by telicent-ai-services by the Istio AuthorizationPolicy
*/}}
{{- define "telicent-ai-services.aiServicesIngressPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "telicent-ai-services.serviceAccountAIservices" .) -}}
{{- end -}}

{{/*
Returns the principal used for Ingress traffic by the Istio AuthorizationPolicy
*/}}
{{- define "telicent-ai-services.ingressPrincipal" -}}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace ( include "telicent-ai-services.serviceAccountTraefikProxy" .) -}}
{{- end -}}