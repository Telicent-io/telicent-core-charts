{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "access-ui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "access-ui.fullname" -}}
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
{{- define "access-ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "access-ui.labels" -}}
telicent.io/resource: "true"
helm.sh/chart: {{ include "access-ui.chart" . }}
{{ include "access-ui.selectorLabels" . }}
app.kubernetes.io/version: {{ include "access-ui.version" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "access-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "access-ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "access-ui.serviceAccountName" -}}
{{- default (include "access-ui.fullname" .) .Values.serviceAccount.name }}
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "access-ui.serviceName" -}}
{{- include "access-ui.fullname" . }}
{{- end }}

{{/*
Create the name of the config map
*/}}
{{- define "access-ui.configMapName" -}}
{{- printf "%s-%s" (include "access-ui.fullname" .) "env-config" }}
{{- end }}

{{- define "access-ui.ingressPrincipal" -}}
{{- .Values.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Values.global.istioNamespace .Values.global.istioServiceAccountName) | quote }}
{{- end }}
