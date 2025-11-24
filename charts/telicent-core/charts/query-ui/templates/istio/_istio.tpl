{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the service account name
a.) when installed through the parent chart, the service account name will include the release name.
b.) when installed through a sub chart, where release name equals 'query-ui' (chart name) the
    release name will not be included.
*/}}
{{- define "query-ui.calServiceAccount" -}}
{{- $envVal := index . 0 -}}
{{- $serviceAccount := index . 1 -}}
{{- $name := default $envVal.Chart.Name $envVal.Values.nameOverride }}
{{- if contains $name $envVal.Release.Name }}
{{- printf "%s" $serviceAccount -}}
{{- else }}
{{- printf "%s-%s" $envVal.Release.Name $serviceAccount }}
{{- end }}
{{- end }}

{{/*
Returns the principal used for Ingress traffic by the Istio AuthorizationPolicy
*/}}
{{- define "query-ui.ingressPrincipal" -}}
{{- if .Values.istio.ingress.principal }}
{{- printf "- %s" .Values.istio.ingress.principal }}
{{- else }}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace (include "query-ui.calServiceAccount" (list . .Values.istio.ingress.serviceAccountName) ) }}
{{- end }}
{{- end }}
