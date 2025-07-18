{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "access-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "access-api.fullname" -}}
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
{{- define "access-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Returns the version
*/}}
{{- define "access-api.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "access-api.labels" -}}
telicent.io/resource: "true"
helm.sh/chart: {{ include "access-api.chart" . }}
{{ include "access-api.selectorLabels" . }}
app.kubernetes.io/version: {{ include "access-api.version" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "access-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "access-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "access-api.serviceAccountName" -}}
{{- default (include "access-api.fullname" .) .Values.serviceAccount.name }}
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "access-api.serviceName" -}}
{{- include "access-api.fullname" . }}
{{- end }}

{{/*
Create the name of the environment secrets
*/}}
{{- define "access-api.envSecretName" -}}
{{- if .Values.mongo.existingMongoPasswordSecret }}
{{- .Values.mongo.existingMongoPasswordSecret }}
{{- else }}
{{- printf "%s-%s" (include "access-api.fullname" .) "env" }}
{{- end }}
{{- end -}}

{{/*
Create the name of the config map
*/}}
{{- define "access-api.envConfigmapName" -}}
{{- if .Values.existingConfigmap }}
{{- .Values.existingConfigmap }}
{{- else }}
{{- printf "%s-%s" (include "access-api.fullname" .) "env" }}
{{- end }}
{{- end }}

{{/*
Create the name of the config map
*/}}
{{- define "access-api.cacertConfigmapName" -}}
{{- if .Values.existingCacertConfigmap -}}
{{- .Values.existingCacertConfigmap }}
{{- else }}
{{- printf "%s-%s" (include "access-api.fullname" .) "cacert" }}
{{- end }}
{{- end }}

{{- define "access-api.ingressPrincipal" -}}
{{- .Values.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Values.global.istioNamespace .Values.global.istioServiceAccountName) | quote }}
{{- end }}

{{- define "access-api.graphServerPrincipal" -}}
{{- .Values.graphServer.principal | default (printf "cluster.local/ns/%s/sa/%s-%s" .Release.Namespace .Release.Name "smart-cache-graph") | quote }}
{{- end }}

{{- define "access-api.searchApiPrincipal" -}}
{{- .Values.searchApi.principal | default (printf "cluster.local/ns/%s/sa/%s-%s" .Release.Namespace .Release.Name "smart-cache-search") | quote }}
{{- end }}