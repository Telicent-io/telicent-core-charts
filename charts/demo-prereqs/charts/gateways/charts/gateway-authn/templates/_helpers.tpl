{{/*
Copyright (C) 2025-2026 Telicent Limited
*/}}

{{/*
Trim the chart name prefix
*/}}
{{- define "gateway-authn.ChartShortName" -}}
{{- .Chart.Name | trimPrefix "gateway-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "gateway-authn.name" -}}
{{- default (include "gateway-authn.ChartShortName" .) .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gateway-authn.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (include "gateway-authn.ChartShortName" .) .Values.nameOverride }}
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
{{- define "gateway-authn.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gateway-authn.labels" -}}
helm.sh/chart: {{ include "gateway-authn.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Auth TLS credential name
*/}}
{{- define "gateway-authn.tlsCredentialName" -}}
{{- if .Values.tls.existingCredentialName -}}
{{- .Values.tls.existingCredentialName -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "authn-tls" -}}
{{- end -}}
{{- end -}}
