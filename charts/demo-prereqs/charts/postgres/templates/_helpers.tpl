{{/*
Copyright (C) 2025-2026 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "demo-prereqs-postgres.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "demo-prereqs-postgres.fullname" -}}
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
{{- define "demo-prereqs-postgres.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "demo-prereqs-postgres.labels" -}}
helm.sh/chart: {{ include "demo-prereqs-postgres.chart" . }}
{{ include "demo-prereqs-postgres.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "demo-prereqs-postgres.selectorLabels" -}}
app.kubernetes.io/name: {{ include "demo-prereqs-postgres.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "demo-prereqs-postgres.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "demo-prereqs-postgres.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Resolve the name of the secret containing the postgres password.
Uses existingSecret if provided, otherwise the chart-managed secret.
*/}}
{{- define "demo-prereqs-postgres.secretName" -}}
{{- if .Values.postgres.existingSecret }}
{{- .Values.postgres.existingSecret }}
{{- else }}
{{- include "demo-prereqs-postgres.fullname" . }}
{{- end }}
{{- end }}

{{/*
Resolve the key in the secret containing the postgres password.
*/}}
{{- define "demo-prereqs-postgres.secretPasswordKey" -}}
{{- if .Values.postgres.existingSecret }}
{{- default "postgres-password" .Values.postgres.existingSecretPasswordKey }}
{{- else }}
{{- "postgres-password" }}
{{- end }}
{{- end }}

{{- define "demo-prereqs-postgres.initDbConfigMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "initdb" }}
{{- end }}

{{/*
Service principals
*/}}
{{- define "demo-prereqs-postgres.authPrincipal" -}}
{{- printf "cluster.local/ns/%s/sa/%s" .Values.auth.namespace .Values.auth.serviceAccountName }}
{{- end }}
{{- define "demo-prereqs-postgres.userPreferencesPrincipal" -}}
{{- printf "cluster.local/ns/%s/sa/%s" .Values.auth.namespace .Values.userPreferences.serviceAccountName }}
{{- end }}
