{{/*
Expand the name of the chart.
*/}}
{{- define "document-pipeline.http-ingester.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-http-ingester
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "document-pipeline.http-ingester.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}-http-ingester
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}-http-ingester
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}-http-ingester
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}-http-ingester
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "document-pipeline.http-ingester.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "document-pipeline.http-ingester.labels" -}}
helm.sh/chart: {{ include "document-pipeline.http-ingester.chart" . }}
{{ include "document-pipeline.http-ingester.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "document-pipeline.http-ingester.selectorLabels" -}}
app.kubernetes.io/name: {{ include "document-pipeline.http-ingester.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "document-pipeline.http-ingester.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "document-pipeline.http-ingester.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
