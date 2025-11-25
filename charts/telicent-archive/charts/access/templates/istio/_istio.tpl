{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Returns the service account name
a.) when installed through the parent chart, the service account name will include the release name.
b.) when installed through a sub chart, where release name equals 'access' (chart name) the
    release name will not be included.
*/}}
{{- define "access.calServiceAccount" -}}
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
{{- define "access.ingressPrincipal" -}}
{{- if .Values.istio.ingress.principal }}
{{- printf "- %s" .Values.istio.ingress.principal }}
{{- else }}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace (include "access.calServiceAccount" (list . .Values.istio.ingress.serviceAccountName) ) }}
{{- end }}
{{- end }}

{{/*
Returns the principal used for User Preferences traffic by the Istio AuthorizationPolicy
*/}}
{{- define "access.userPreferencesPrincipal" -}}
{{- if .Values.istio.userPreferences.principal }}
{{- printf "- %s" .Values.istio.userPreferences.principal }}
{{- else }}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace (include "access.calServiceAccount" (list . .Values.istio.userPreferences.serviceAccountName) ) }}
{{- end }}
{{- end }}

{{/*
Returns the principal used for Graph traffic by the Istio AuthorizationPolicy
*/}}
{{- define "access.graphPrincipal" -}}
{{- if .Values.istio.graph.principal }}
{{- printf "- %s" .Values.istio.graph.principal }}
{{- else }}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace (include "access.calServiceAccount" (list . .Values.istio.graph.serviceAccountName) ) }}
{{- end }}
{{- end }}

{{/*
Returns the principal used for Search traffic by the Istio AuthorizationPolicy
*/}}
{{- define "access.searchPrincipal" -}}
{{- if .Values.global.enterprise }}
{{- if .Values.istio.search.principal }}
{{- printf "- %s" .Values.istio.search.principal }}
{{- else }}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace (include "access.calServiceAccount" (list . .Values.istio.search.serviceAccountName) ) }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Returns the principal used for Paperback Writer traffic by the Istio AuthorizationPolicy
*/}}
{{- define "access.paperbackWriterPrincipal" -}}
{{- if .Values.global.enterprise }}
{{- if .Values.istio.paperbackWriter.principal }}
{{- printf "- %s" .Values.istio.paperbackWriter.principal }}
{{- else }}
{{- printf "- cluster.local/ns/%s/sa/%s" .Release.Namespace (include "access.calServiceAccount" (list . .Values.istio.paperbackWriter.serviceAccountName) ) }}
{{- end }}
{{- end }}
{{- end }}
