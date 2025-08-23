{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "user-preferences.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "user-preferences.fullname" -}}
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
{{- define "user-preferences.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "user-preferences.labels" -}}
helm.sh/chart: {{ include "user-preferences.chart" . }}
{{ include "user-preferences.selectorLabels" . }}
app.kubernetes.io/version: {{ include "user-preferences.version" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
telicent.io/resource: "true"
{{- end }}

{{/*
Selector labels
*/}}
{{- define "user-preferences.selectorLabels" -}}
app.kubernetes.io/name: {{ include "user-preferences.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "user-preferences.serviceAccountName" -}}
{{- default (include "user-preferences.fullname" .) .Values.serviceAccount.name }}
{{ end }}

{{/*
Create the name of the service to use
*/}}
{{- define "user-preferences.serviceName" -}}
{{ include "user-preferences.fullname" . }}
{{- end }}

{{- define "user-preferences.envSecretName" -}}
{{ include "user-preferences.fullname" . }}-server
{{- end }}

{{/*
Create the name of the config map
*/}}
{{- define "user-preferences.envConfigmapName" -}}
{{- if .Values.existingConfigmap }}
{{- .Values.existingConfigmap }}
{{- else }}
{{- printf "%s-%s" (include "user-preferences.fullname" .) "env" }}
{{- end }}
{{- end }}

{{/*
Create Server config name to use
*/}}
{{- define "user-preferences.serverConfig" -}}
{{ include "user-preferences.fullname" . }}-server-config
{{- end }}

{{/* 
Create Kafka Auth Config name to use
*/}}
{{- define "user-preferences.kafkaAuthConfig" -}}
{{ include "user-preferences.fullname" . }}-kafka-auth-config
{{- end }}

{{/* 
Create MongoPassword name to use
*/}}
{{- define "user-preferences.secret" -}}
{{ include "user-preferences.fullname" . }}-secret
{{- end }}

{{- define "user-preferences.ingressPrincipal" -}}
{{- .Values.istio.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Values.global.istioNamespace .Values.global.istioServiceAccountName) | quote }}
{{- end }}
