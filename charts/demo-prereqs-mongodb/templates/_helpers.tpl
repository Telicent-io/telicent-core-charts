{{/*
Expand the name of the chart.
*/}}
{{- define "mongodb.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mongodb.fullname" -}}
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
{{- define "mongodb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mongodb.labels" -}}
helm.sh/chart: {{ include "mongodb.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mongodb.serviceAccountName" -}}
{{- default (include "mongodb.fullname" .) .Values.serviceAccountName }}
{{- end }}


{{/*
Admin password credential
*/}}
{{- define "mongodb.adminPwdSecretName" -}}
{{- if .Values.existingAdminPwdSecretName -}}
{{- .Values.existingAdminPwdSecretName -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "admin-pwd" -}}
{{- end -}}
{{- end -}}

{{/*
Admin scram credential
*/}}
{{- define "mongodb.adminScramSecretName" -}}
{{- printf "%s-%s" (include "mongodb.adminPwdSecretName" .) "scram" }}
{{- end }}

{{/*
Access password
*/}}
{{- define "mongodb.accessPwdSecretName" -}}
{{- if .Values.existingAccessPwdSecretName -}}
{{- .Values.existingAccessPwdSecretName -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "access-pwd" -}}
{{- end -}}
{{- end -}}

{{/*
Access scram credential
*/}}
{{- define "mongodb.accessScramSecretName" -}}
{{- printf "%s-%s" (include "mongodb.accessPwdSecretName" .) "scram" }}
{{- end }}
