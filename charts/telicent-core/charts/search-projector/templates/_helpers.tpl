{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "search-projector.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "search-projector.fullname" -}}
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
{{- define "search-projector.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "search-projector.labels" -}}
helm.sh/chart: {{ include "search-projector.chart" . }}
{{ include "search-projector.selectorLabels" . }}
app.kubernetes.io/version: {{ include "search-projector.version" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
telicent.io/resource: "true"
{{- end }}

{{/*
Selector labels
*/}}
{{- define "search-projector.selectorLabels" -}}
app.kubernetes.io/name: {{ include "search-projector.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "search-projector.serviceAccountName" -}}
{{- default (printf "%s" (include "search-projector.fullname" .)) .Values.serviceAccount.name }}
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "search-projector.serviceName" -}}
{{- include "search-projector.fullname" . }}
{{- end }}

{{/*
Create the name of the config map
*/}}
{{- define "search-projector.envConfigmapName" -}}
{{- if .Values.existingConfigmap }}
{{- .Values.existingConfigmap }}
{{- else }}
{{- printf "%s-%s" (include "search-projector.fullname" .) "env" }}
{{- end }}
{{- end }}

{{/*
Create the name of environment variable secrets
*/}}
{{- define "search-projector.EnvSecretName" -}}
{{ include "search-projector.fullname" . }}
{{- end }}
