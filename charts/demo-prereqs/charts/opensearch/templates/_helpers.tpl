{{/*
Copyright (C) 2025-2026 Telicent Limited
*/}}

{{/*
Trim the chart name prefix
*/}}
{{- define "opensearch-deps.ChartShortName" -}}
{{- .Chart.Name | trimPrefix "opensearch-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "opensearch-deps.name" -}}
{{- default (include "opensearch-deps.ChartShortName" .) .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "opensearch-deps.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (include "opensearch-deps.ChartShortName" .) .Values.nameOverride }}
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
{{- define "opensearch-deps.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Namespace
*/}}
{{- define "opensearch-deps.namespace" -}}
{{- .Values.namespace | default .Release.Namespace }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "opensearch-deps.labels" -}}
helm.sh/chart: {{ include "opensearch-deps.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "opensearch-deps.selectorLabels" -}}
app.kubernetes.io/name: {{ include "opensearch-deps.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
