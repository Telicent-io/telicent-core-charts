{{/*
Expand the name of the chart.
*/}}
{{- define "oauth2-proxy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "oauth2-proxy.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "oauth2-proxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "oauth2-proxy.labels" -}}
helm.sh/chart: {{ include "oauth2-proxy.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/app: {{ include "oauth2-proxy.name" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Internal labels
*/}}
{{- define "oauth2-proxy.internalLabels" -}}
helm.sh/chart: {{ include "oauth2-proxy.chart" . }}
{{ include "oauth2-proxy.internalSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
External labels
*/}}
{{- define "oauth2-proxy.externalLabels" -}}
helm.sh/chart: {{ include "oauth2-proxy.chart" . }}
{{ include "oauth2-proxy.externalSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Internal Selector labels
*/}}
{{- define "oauth2-proxy.internalSelectorLabels" -}}
app.kubernetes.io/component: internal
{{- end }}

{{/*
Internal Selector labels
*/}}
{{- define "oauth2-proxy.externalSelectorLabels" -}}
app.kubernetes.io/component: external
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "oauth2-proxy.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "oauth2-proxy.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the environment secrets
*/}}
{{- define "oauth2-proxy.envSecretName" -}}
{{- if .Values.existingEnvSecretName -}}
{{- .Values.existingEnvSecretName }}
{{- else }}
{{- printf "%s-%s" (include "oauth2-proxy.fullname" .) "env" }}
{{- end }}
{{- end }}

{{/*
Create the name of the internal configMap
*/}}
{{- define "oauth2-proxy.internalEnvConfigmapName" -}}
{{- if .Values.existingEnvConfigmapName -}}
{{- .Values.existingEnvConfigmapName }}
{{- else }}
{{- printf "%s-%s-%s" (include "oauth2-proxy.fullname" .) "internal" "env" }}
{{- end }}
{{- end }}

{{/*
Create the name of the external configMap
*/}}
{{- define "oauth2-proxy.externalEnvConfigmapName" -}}
{{- if .Values.existingEnvConfigmapName -}}
{{- .Values.existingEnvConfigmapName }}
{{- else }}
{{- printf "%s-%s-%s" (include "oauth2-proxy.fullname" .) "external" "env" }}
{{- end }}
{{- end }}

{{/*
Create the name of the config map
*/}}
{{- define "oauth2-proxy.cacertConfigmapName" -}}
{{- if .Values.existingCacertConfigmap -}}
{{- .Values.existingCacertConfigmap }}
{{- else }}
{{- printf "%s-%s" (include "oauth2-proxy.fullname" .) "cacert" }}
{{- end }}
{{- end }}

{{/*
Create the oidcRedirectURL
*/}}
{{- define "oauth2-proxy.oidcRedirectUrl" -}}
{{- if .Values.configuration.redirectURLOverride }}
{{- .Values.configuration.redirectUrlOverride }}
{{- else }}
{{- printf "https://%s/oauth2/callback" .Values.global.appHostDomain }}
{{- end }}
{{- end }}

{{/*
{{- printf "%s/oauth2/callback" .Values.global.appHostDomain }}
*/}}

{{- define "oauth2-proxy.ingressPrincipal" -}}
{{- .Values.istio.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Values.global.istioNamespace .Values.global.istioServiceAccountName) | quote }}
{{- end }}
