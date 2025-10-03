{{/*
Trim the chart name prefix
*/}}
{{- define "kafka.ChartShortName" -}}
{{- .Chart.Name | trimPrefix "demo-prereqs-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "kafka.name" -}}
{{- default (include "kafka.ChartShortName" .) .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kafka.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (include "kafka.ChartShortName" .) .Values.nameOverride }}
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
{{- define "kafka.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kafka.labels" -}}
helm.sh/chart: {{ include "kafka.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Admin password credential
*/}}
{{- define "kafka.userPwdSecretName" -}}
{{- if .Values.existingUserPwdSecretName -}}
{{- .Values.existingUserPwdSecretName -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "passwords" -}}
{{- end -}}
{{- end -}}
