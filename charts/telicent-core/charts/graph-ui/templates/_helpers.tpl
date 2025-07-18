{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "graph.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "graph.fullname" -}}
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
{{- define "graph.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "graph.labels" -}}
helm.sh/chart: {{ include "graph.chart" . }}
{{ include "graph.selectorLabels" . }}
app.kubernetes.io/version: {{ include "graph.version" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
telicent.io/resource: "true"
{{- end }}

{{/*
Selector labels
*/}}
{{- define "graph.selectorLabels" -}}
app.kubernetes.io/name: {{ include "graph.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "graph.serviceAccountName" -}}
{{- default (include "graph.fullname" .) .Values.serviceAccount.name }}
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "graph.serviceName" -}}
{{- include "graph.fullname" . }}
{{- end }}

{{/*
Create the name of the config map
*/}}
{{- define "graph.configMapName" -}}
{{- printf "%s-%s" (include "graph.fullname" .) "env-configjs" }}
{{- end }}

{{/*
Create the name of the config secret
*/}}
{{- define "graph.configSecretName" -}}
{{- printf "%s-%s" (include "graph.fullname" .) "secret-config-js" }}
{{- end }}

{{- define "graph.ingressPrincipal" -}}
{{- .Values.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Values.global.istioNamespace .Values.global.istioServiceAccountName) | quote }}
{{- end }}
