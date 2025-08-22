{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "access.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "access.fullname" -}}
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
{{- define "access.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "access.labels" -}}
helm.sh/chart: {{ include "access.chart" . }}
{{ include "access.selectorLabels" . }}
app.kubernetes.io/version: {{ include "access.version" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
telicent.io/resource: "true"
{{- end }}

{{/*
Selector labels
*/}}
{{- define "access.selectorLabels" -}}
app.kubernetes.io/name: {{ include "access.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "access.serviceAccountName" -}}
{{- default (include "access.fullname" .) .Values.serviceAccount.name }}
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "access.serviceName" -}}
{{- include "access.fullname" . }}
{{- end }}

{{/*
Create the name of the environment secrets
*/}}
{{- define "access.envSecretName" -}}
{{- if .Values.mongo.existingMongoPasswordSecret }}
{{- .Values.mongo.existingMongoPasswordSecret }}
{{- else }}
{{- printf "%s-%s" (include "access.fullname" .) "env" }}
{{- end }}
{{- end -}}

{{/*
Create the name of the config map
*/}}
{{- define "access.envConfigmapName" -}}
{{- if .Values.existingConfigmap }}
{{- .Values.existingConfigmap }}
{{- else }}
{{- printf "%s-%s" (include "access.fullname" .) "env" }}
{{- end }}
{{- end }}

{{/*
Create the name of the config map
*/}}
{{- define "access.cacertConfigmapName" -}}
{{- if .Values.existingCacertConfigmap -}}
{{- .Values.existingCacertConfigmap }}
{{- else }}
{{- printf "%s-%s" (include "access.fullname" .) "cacert" }}
{{- end }}
{{- end }}

{{- define "access.ingressPrincipal" -}}
{{- .Values.istio.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Values.global.istioNamespace .Values.global.istioServiceAccountName) | quote }}
{{- end }}

{{- define "access.graphPrincipal" -}}
{{- .Values.istio.graph.principal | default (printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.istio.graph.serviceAccountName) | quote }}
{{- end }}

{{- define "access.searchPrincipal" -}}
{{- .Values.istio.search.principal | default (printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.istio.search.serviceAccountName) | quote }}
{{- end }}