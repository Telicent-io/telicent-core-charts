{{/*
Expand the name of the chart.
*/}}
{{- define "core-mesh.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "core-mesh.fullname" -}}
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
{{- define "core-mesh.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "core-mesh.labels" -}}
telicent.io/resource: "true"
helm.sh/chart: {{ include "core-mesh.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Service principals
*/}}
{{- define "core-mesh.accessApiPrincipal" -}}
{{- printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.accessApi.serviceAccountName }}
{{- end }}

{{- define "core-mesh.ingressPrincipal" -}}
{{- printf "cluster.local/ns/%s/sa/%s" .Values.ingress.namespace .Values.ingress.serviceAccountName }}
{{- end }}

{{- define "core-mesh.graphServerPrincipal" -}}
{{- printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.graphServer.serviceAccountName }}
{{- end }}

{{- define "core-mesh.searchApiPrincipal" -}}
{{- printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.searchApi.serviceAccountName }}
{{- end }}

{{/*
Selectors
*/}}
{{- define "core-mesh.accessApiSelectors" -}}
app.kubernetes.io/instance: {{ .Values.accessApi.instance }}
app.kubernetes.io/name: {{ .Values.accessApi.name }}
{{- end }}

{{- define "core-mesh.accessUiSelectors" -}}
app.kubernetes.io/instance: {{ .Values.accessUi.instance }}
app.kubernetes.io/name: {{ .Values.accessUi.name }}
{{- end }}

{{- define "core-mesh.graphServerSelectors" -}}
app.kubernetes.io/instance: {{ .Values.graphServer.instance }}
app.kubernetes.io/name: {{ .Values.graphServer.name }}
{{- end }}

{{- define "core-mesh.querySelectors" -}}
app.kubernetes.io/instance: {{ .Values.query.instance }}
app.kubernetes.io/name: {{ .Values.query.name }}
{{- end }}

{{- define "core-mesh.searchUiSelectors" -}}
{{- if .Values.closedSourceDeployment }}
app.kubernetes.io/instance: {{ .Values.searchUi.instance }}
app.kubernetes.io/name: {{ .Values.searchUi.name }}
{{- end }}
{{- end }}

{{- define "core-mesh.graphUiSelectors" -}}
{{- if .Values.closedSourceDeployment }}
app.kubernetes.io/instance: {{ .Values.graphUi.instance }}
app.kubernetes.io/name: {{ .Values.graphUi.name }}
{{- end }}
{{- end }}

{{- define "core-mesh.searchApiSelectors" -}}
{{- if .Values.closedSourceDeployment }}
app.kubernetes.io/instance: {{ .Values.searchApi.instance }}
app.kubernetes.io/name: {{ .Values.searchApi.name }}
{{- end }}
{{- end }}

{{/*
Jwks URI
*/}}
{{- define "core-mesh.jwksUri" -}}
{{- if .Values.global.jwksUrl -}}
{{- .Values.global.jwksUrl -}}
{{- else -}}
{{- printf "https://%s/realms/core/protocol/openid-connect/certs" .Values.authnHost -}}
{{- end -}}
{{- end -}}

{{/*
JWT Issuer
*/}}
{{- define "core-mesh.jwtIssuer" -}}
{{- if .Values.jwtIssuer -}}
{{- .Values.jwtIssuer -}}
{{- else -}}
{{- printf "https://%s/realms/core" .Values.authnHost -}}
{{- end -}}
{{- end -}}
