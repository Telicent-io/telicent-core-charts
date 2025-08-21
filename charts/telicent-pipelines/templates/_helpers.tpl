{{/*
Expand the name of the chart.
*/}}
{{- define "telicent-pipelines.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "telicent-pipelines.fullname" -}}
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
{{- define "telicent-pipelines.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "telicent-pipelines.labels" -}}
helm.sh/chart: {{ include "telicent-pipelines.chart" . }}
{{ include "telicent-pipelines.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "telicent-pipelines.selectorLabels" -}}
app.kubernetes.io/name: {{ include "telicent-pipelines.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Kafka Auth Secret Name
*/}}
{{- define "telicent-pipelines.kafkaAuthConfigSecretName" -}}
{{- if .Values.existingKafkaConfigSecretName }}
{{- .Values.kafka.auth.secretName | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-kafka-auth" (include "telicent-pipelines.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
