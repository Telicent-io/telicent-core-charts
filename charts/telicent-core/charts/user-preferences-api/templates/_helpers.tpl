{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "user-preferences-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "user-preferences-api.fullname" -}}
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
{{- define "user-preferences-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "user-preferences-api.labels" -}}
telicent.io/resource: "true"
helm.sh/chart: {{ include "user-preferences-api.chart" . }}
{{ include "user-preferences-api.selectorLabels" . }}
app.kubernetes.io/version: {{ include "user-preferences-api.version" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "user-preferences-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "user-preferences-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "user-preferences-api.serviceAccountName" -}}
{{- default (include "user-preferences-api.fullname" .) .Values.serviceAccount.name }}
{{ end }}

{{/*
Create the name of the service to use
*/}}
{{- define "user-preferences-api.serviceName" -}}
{{ include "user-preferences-api.fullname" . }}
{{- end }}

{{- define "user-preferences-api.envSecretName" -}}
{{ include "user-preferences-api.fullname" . }}-server
{{- end }}

{{/*
Create Server config name to use
*/}}
{{- define "user-preferences-api.serverConfig" -}}
{{ include "user-preferences-api.fullname" . }}-server-config
{{- end }}

{{/* 
Create Kafka Auth Config name to use
*/}}
{{- define "user-preferences-api.kafkaAuthConfig" -}}
{{ include "user-preferences-api.fullname" . }}-kafka-auth-config
{{- end }}

{{/* 
Create MongoPassword name to use
*/}}
{{- define "user-preferences-api.secret" -}}
{{ include "user-preferences-api.fullname" . }}-secret
{{- end }}

{{- define "user-preferences-api.ingressPrincipal" -}}
{{- .Values.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Values.global.istioNamespace .Values.global.istioServiceAccountName) | quote }}
{{- end }}
