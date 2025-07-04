{{/*
Expand the name of the chart.
*/}}
{{- define "smart-cache-search.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "smart-cache-search.fullname" -}}
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
{{- define "smart-cache-search.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Returns the version of the api
*/}}
{{- define "smart-cache-search-api.version" -}}
{{ .Values.api.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the version of the projector
*/}}
{{- define "smart-cache-search-projector.version" -}}
{{ .Values.projector.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "smart-cache-search.commonLabels" -}}
telicent.io/resource: "true"
helm.sh/chart: {{ include "smart-cache-search.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Application specific labels
*/}}
{{- define "smart-cache-search.apiLabels" -}}
{{ include "smart-cache-search.apiSelectorLabels" . }}
{{ include "smart-cache-search.commonLabels" . }}
app.kubernetes.io/version: {{ include "smart-cache-search-api.version" . | quote }}
{{- end }}

{{- define "smart-cache-search.projectorLabels" -}}
{{ include "smart-cache-search.projectorSelectorLabels" . }}
{{ include "smart-cache-search.commonLabels" . }}
app.kubernetes.io/version: {{ include "smart-cache-search-projector.version" . | quote }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "smart-cache-search.apiSelectorLabels" -}}
app.kubernetes.io/name: {{ include "smart-cache-search.name" . }}-api
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "smart-cache-search.projectorSelectorLabels" -}}
app.kubernetes.io/name: {{ include "smart-cache-search.name" . }}-projector
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "smart-cache-search.serviceAccountName" -}}
{{- default (include "smart-cache-search.fullname" .) .Values.serviceAccount.name }}
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "smart-cache-search.serviceName" -}}
{{- include "smart-cache-search.fullname" . }}
{{- end }}

{{/*
Create the name of environment variable secrets
*/}}
{{- define "smart-cache-search.apiEnvSecretName" -}}
{{ include "smart-cache-search.fullname" . }}-api
{{- end }}

{{- define "smart-cache-search.projectorEnvSecretName" -}}
{{ include "smart-cache-search.fullname" . }}-projector
{{- end }}

{{- define "smart-cache-search.ingressPrincipal" -}}
{{- .Values.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Values.global.istioNamespace .Values.global.istioServiceAccountName) | quote }}
{{- end }}

{{- define "smart-cache-search.graphServerPrincipal" -}}
{{- .Values.graphServer.principal | default (printf "cluster.local/ns/%s/sa/%s-%s" .Release.Namespace .Release.Name "smart-cache-graph") | quote }}
{{- end }}