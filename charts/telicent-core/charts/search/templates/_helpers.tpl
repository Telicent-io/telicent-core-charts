{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "search.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "search.fullname" -}}
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
{{- define "search.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "search.labels" -}}
helm.sh/chart: {{ include "search.chart" . }}
{{ include "search.selectorLabels" . }}
app.kubernetes.io/version: {{ include "search.version" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
telicent.io/resource: "true"
{{- end }}

{{/*
Selector labels
*/}}
{{- define "search.selectorLabels" -}}
app.kubernetes.io/name: {{ include "search.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "search.serviceAccountName" -}}
{{- default (printf "%s" (include "search.fullname" .)) .Values.serviceAccount.name }}
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "search.serviceName" -}}
{{- include "search.fullname" . }}
{{- end }}

{{/*
Create the name of the config map
*/}}
{{- define "search.envConfigmapName" -}}
{{- if .Values.existingConfigmap }}
{{- .Values.existingConfigmap }}
{{- else }}
{{- printf "%s-%s" (include "search.fullname" .) "env" }}
{{- end }}
{{- end }}

{{/*
Create the name of environment variable secrets
*/}}
{{- define "search.envSecretName" -}}
{{ include "search.fullname" . }}
{{- end }}

{{- define "search.ingressPrincipal" -}}
{{- .Values.istio.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Values.global.istioNamespace .Values.global.istioServiceAccountName) | quote }}
{{- end }}

{{- define "search.graphPrincipal" -}}
{{- .Values.istio.graph.principal | default (printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.istio.graph.serviceAccountName ) | quote }}
{{- end }}
