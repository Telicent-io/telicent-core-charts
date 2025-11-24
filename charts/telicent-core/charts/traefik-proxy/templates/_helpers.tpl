{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "traefik-proxy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Allow the release namespace to be overridden.
*/}}
{{- define "traefik-proxy.namespace" -}}
{{- if .Values.namespaceOverride -}}
{{- .Values.namespaceOverride -}}
{{- else -}}
{{- .Release.Namespace -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "traefik-proxy.fullname" -}}
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
{{- define "traefik-proxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "traefik-proxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "traefik-proxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "traefik-proxy.labels" -}}
helm.sh/chart: {{ include "traefik-proxy.chart" . }}
{{ include "traefik-proxy.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ include "traefik-proxy.version" . | quote }}
app: {{ include "traefik-proxy.name" . }}
telicent.io/resource: "true"
{{- range $key, $value := .Values.commonLabels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use (based on the fullname).
*/}}
{{- define "traefik-proxy.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "traefik-proxy.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- .Values.serviceAccount.name | default "default" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service to use (based on the fullname).
*/}}
{{- define "traefik-proxy.serviceName" -}}
{{- if .Values.service.name }}
{{- .Values.service.name -}}
{{- else }}
{{- include "traefik-proxy.fullname" . }}
{{- end }}
{{- end }}
