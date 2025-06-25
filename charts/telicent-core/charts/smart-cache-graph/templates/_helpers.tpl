{{/*
Expand the name of the chart.
*/}}
{{- define "smart-cache-graph.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "smart-cache-graph.fullname" -}}
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
{{- define "smart-cache-graph.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Returns the version
*/}}
{{- define "smart-cache-graph.version" -}}
{{ .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "smart-cache-graph.labels" -}}
telicent.io/resource: "true"
helm.sh/chart: {{ include "smart-cache-graph.chart" . }}
{{ include "smart-cache-graph.selectorLabels" . }}
app.kubernetes.io/version: {{ include "smart-cache-graph.version" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "smart-cache-graph.selectorLabels" -}}
app.kubernetes.io/name: {{ include "smart-cache-graph.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "smart-cache-graph.serviceAccountName" -}}
{{- default (include "smart-cache-graph.fullname" .) .Values.serviceAccount.name }}
{{ end }}

{{/*
Create the name of the service to use
*/}}
{{- define "smart-cache-graph.serviceName" -}}
{{ include "smart-cache-graph.fullname" . }}
{{- end }}

{{- define "smart-cache-graph.envSecretName" -}}
{{ include "smart-cache-graph.fullname" . }}-server
{{- end }}

{{/*
Create Server config name to use
*/}}
{{- define "smart-cache-graph.serverConfig" -}}
{{ include "smart-cache-graph.fullname" . }}-server-config
{{- end }}

{{/* 
Create Kafka Auth Config name to use
*/}}
{{- define "smart-cache-graph.kafkaAuthConfig" -}}
{{ include "smart-cache-graph.fullname" . }}-kafka-auth-config
{{- end }}

{{/*
Search API URL
*/}}
{{- define "smart-cache-graph.searchApiUrl" -}}
{{- printf "http://%s-smart-cache-search-api:8181" (.Release.Name) }}
{{- end }}
{{/*
*/}}