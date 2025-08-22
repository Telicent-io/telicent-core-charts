{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "query-ui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "query-ui.fullname" -}}
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
{{- define "query-ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "query-ui.labels" -}}
helm.sh/chart: {{ include "query-ui.chart" . }}
{{ include "query-ui.selectorLabels" . }}
app.kubernetes.io/version: {{ include "query-ui.version" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
telicent.io/resource: "true"
{{- end }}

{{/*
Selector labels
*/}}
{{- define "query-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "query-ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "query-ui.serviceAccountName" -}}
{{- default (include "query-ui.fullname" .) .Values.serviceAccount.name }}
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "query-ui.serviceName" -}}
{{- include "query-ui.fullname" . }}
{{- end }}

{{/*
Create the name of the config map
*/}}
{{- define "query-ui.configMapName" -}}
{{- printf "%s-%s" (include "query-ui.fullname" .) "env-configjs" }}
{{- end }}

{{- define "query-ui.ingressPrincipal" -}}
{{- .Values.istio.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Values.global.istioNamespace .Values.global.istioServiceAccountName) | quote }}
{{- end }}
