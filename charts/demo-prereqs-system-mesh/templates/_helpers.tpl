{{/*
Expand the name of the chart.
*/}}
{{- define "system-mesh.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "system-mesh.fullname" -}}
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
{{- define "system-mesh.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "system-mesh.labels" -}}
telicent.io/resource: "true"
helm.sh/chart: {{ include "system-mesh.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Service principals
*/}}
{{- define "system-mesh.internalOauth2ProxyPrincipal" -}}
{{- printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.oauth2proxy.internal.serviceAccountName }}
{{- end }}

{{- define "system-mesh.externalOauth2ProxyPrincipal" -}}
{{- printf "cluster.local/ns/%s/sa/%s" .Release.Namespace .Values.oauth2proxy.external.serviceAccountName }}
{{- end }}

{{- define "system-mesh.ingressPrincipal" -}}
{{- printf "cluster.local/ns/%s/sa/%s" .Values.ingress.namespace .Values.ingress.serviceAccountName }}
{{- end }}

{{/*
Selectors
*/}}
{{- define "system-mesh.keycloakSelectors" -}}
app.kubernetes.io/instance: {{ .Values.keycloak.instance }}
app.kubernetes.io/name: {{ .Values.keycloak.name }}
{{- end }}

{{- define "system-mesh.internalOauth2ProxySelectors" -}}
app.kubernetes.io/instance: {{ .Values.oauth2proxy.internal.instance }}
app.kubernetes.io/name: {{ .Values.oauth2proxy.internal.name }}
{{- end }}

{{- define "system-mesh.externalOauth2ProxySelectors" -}}
app.kubernetes.io/instance: {{ .Values.oauth2proxy.external.instance }}
app.kubernetes.io/name: {{ .Values.oauth2proxy.external.name }}
{{- end }}
