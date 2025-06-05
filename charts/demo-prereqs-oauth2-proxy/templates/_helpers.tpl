{{/*
Trim the chart name prefix
*/}}
{{- define "oauth2-proxy.ChartShortName" -}}
{{- .Chart.Name | trimPrefix "demo-prereqs-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "oauth2-proxy.name" -}}
{{- default (include "oauth2-proxy.ChartShortName" .) .Values.nameOverride | trunc 63 | trimSuffix "-" }}
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
{{- $name := default (include "oauth2-proxy.ChartShortName" .) .Values.nameOverride }}
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
telicent.io/resource: "true"
helm.sh/chart: {{ include "oauth2-proxy.chart" . }}
{{ include "oauth2-proxy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "oauth2-proxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "oauth2-proxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "oauth2-proxy.serviceAccountName" -}}
{{- default (include "oauth2-proxy.fullname" .) .Values.serviceAccount.name }}
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "oauth2-proxy.serviceName" -}}
{{- include "oauth2-proxy.fullname" . }}
{{- end }}

{{/*
Create the name of the environment secrets
*/}}
{{- define "oauth2-proxy.envSecretName" -}}
{{- if .Values.existingEnvSecret -}}
{{- .Values.existingEnvSecret }}
{{- else }}
{{- printf "%s-%s" (include "oauth2-proxy.fullname" .) "env" }}
{{- end }}
{{- end }}

{{/*
Create the name of the config map
*/}}
{{- define "oauth2-proxy.envConfigmapName" -}}
{{- if .Values.existingEnvConfigmap -}}
{{- .Values.existingEnvConfigmap }}
{{- else }}
{{- printf "%s-%s" (include "oauth2-proxy.fullname" .) "env" }}
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