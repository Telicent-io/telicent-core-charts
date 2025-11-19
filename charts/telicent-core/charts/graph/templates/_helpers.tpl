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
Allow the release namespace to be overridden.
*/}}
{{- define "graph.namespace" -}}
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
Selector labels
*/}}
{{- define "graph.selectorLabels" -}}
app.kubernetes.io/name: {{ include "graph.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "graph.labels" -}}
helm.sh/chart: {{ include "graph.chart" . }}
{{ include "graph.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ include "graph.version" . | quote }}
app: {{ include "graph.name" . }}
telicent.io/resource: "true"
{{- range $key, $value := .Values.commonLabels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "graph.serviceAccountName" -}}
{{- default (include "graph.name" .) .Values.serviceAccount.name }}
{{ end }}

{{/*
Create the name of the service to use
*/}}
{{- define "graph.serviceName" -}}
{{ include "graph.fullname" . }}
{{- end }}



{{- define "graph.envSecretName" -}}
{{ include "graph.fullname" . }}
{{- end }}


{{/*
Search API URL
TODO: fix this
*/}}
{{- define "graph.searchUrl" -}}
{{- printf "http://search:8181" }}
{{- end }}
{{/*
*/}}

{{/*
Default User Preferences URL
*/}}
{{- define "graph.userPreferencesUrl" -}}
{{- printf "http://%s-access:8080/users/lookup/{user}" (.Release.Name) }}
{{- end }}

{{/*
Default Atrribute Hierarchy URL
*/}}
{{- define "graph.attributeHierachyUrl" -}}
{{- printf "http://%s-access:8080/hierarchies/lookup/{name}" (.Release.Name) }}
{{- end }}
