{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "user-portal-ui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Allow the release namespace to be overridden.
*/}}
{{- define "user-portal-ui.namespace" -}}
{{- if .Values.namespaceOverride -}}
{{- .Values.namespaceOverride -}}
{{- else -}}
{{- .Release.Namespace -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "user-portal-ui.fullname" -}}
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
{{- define "user-portal-ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "user-portal-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "user-portal-ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "user-portal-ui.labels" -}}
helm.sh/chart: {{ include "user-portal-ui.chart" . }}
{{ include "user-portal-ui.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ include "user-portal-ui.version" . | quote }}
app: {{ include "user-portal-ui.name" . }}
telicent.io/resource: "true"
{{- range $key, $value := .Values.commonLabels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use (based on the fullname).
*/}}
{{- define "user-portal-ui.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "user-portal-ui.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- .Values.serviceAccount.name | default "default" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service to use (based on the fullname).
*/}}
{{- define "user-portal-ui.serviceName" -}}
{{- if .Values.service.name }}
{{- .Values.service.name -}}
{{- else }}
{{- include "user-portal-ui.fullname" . }}
{{- end }}
{{- end }}
