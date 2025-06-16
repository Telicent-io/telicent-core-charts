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
Service names
*/}}

{{- define "core-mesh.accessApiServiceName" -}}
{{- .Values.accessApi.serviceName | default (printf "%s-%s" .Release.Name "access-api") | quote }}
{{- end -}}

{{- define "core-mesh.accessUiServiceName" -}}
{{- .Values.accessUi.serviceName | default (printf "%s-%s" .Release.Name "access-ui") | quote }}
{{- end -}}

{{- define "core-mesh.queryUiServiceName" -}}
{{- .Values.queryUi.serviceName | default (printf "%s-%s" .Release.Name "query-ui") | quote }}
{{- end -}}

{{- define "core-mesh.searchUiServiceName" -}}
{{- .Values.searchUi.serviceName | default (printf "%s-%s" .Release.Name "search-ui") | quote }}
{{- end -}}

{{- define "core-mesh.graphUiServiceName" -}}
{{- .Values.graphUi.serviceName | default (printf "%s-%s" .Release.Name "graph-ui") | quote }}
{{- end -}}

{{- define "core-mesh.graphServerServiceName" -}}
{{- .Values.graphServer.serviceName | default (printf "%s-%s" $.Release.Name "smart-cache-graph") | quote }}
{{- end }}

{{- define "core-mesh.searchApiServiceName" -}}
{{- .Values.searchApi.serviceName | default (printf "%s-%s" $.Release.Name "smart-cache-search-api") | quote }}
{{- end }}

{{/*
Service principals
*/}}
{{- define "core-mesh.ingressPrincipal" -}}
{{- .Values.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Values.ingress.namespace "istio-ingress") | quote }}
{{- end }}

{{- define "core-mesh.graphServerPrincipal" -}}
{{- .Values.graphServer.principal | default (printf "cluster.local/ns/%s/sa/%s-%s" .Release.Namespace .Release.Name "smart-cache-graph") quote }}
{{- end }}

{{- define "core-mesh.searchApiPrincipal" -}}
{{- .Values.searchApi.principal | default (printf "cluster.local/ns/%s/sa/%s-%s" .Release.Namespace .Release.Name "smart-cache-search") | quote }}
{{- end }}

{{/*
Selectors
*/}}
{{- define "core-mesh.accessApiSelectors" -}}
{{- if .Values.accessApi.selectors -}}
{{ .Values.accessApi.selectors | toYaml }}
{{- else -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: access-api
{{- end -}}
{{- end -}}

{{- define "core-mesh.accessUiSelectors" -}}
{{- if .Values.accessUi.selectors -}}
{{ .Values.accessUi.selectors | toYaml }}
{{- else -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: access-ui
{{- end -}}
{{- end -}}

{{- define "core-mesh.graphServerSelectors" -}}
{{- if .Values.graphServer.selectors -}}
{{ .Values.graphServer.selectors | toYaml }}
{{- else -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: smart-cache-graph
{{- end -}}
{{- end -}}

{{- define "core-mesh.queryUiSelectors" -}}
{{- if .Values.queryUi.selectors -}}
{{ .Values.queryUi.selectors | toYaml }}
{{- else -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: query-ui
{{- end -}}
{{- end -}}

{{- define "core-mesh.searchUiSelectors" -}}
{{- if .Values.global.enterprise }}
{{- if .Values.searchUi.selectors -}}
{{ .Values.searchUi.selectors | toYaml }}
{{- else -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: search-ui
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "core-mesh.graphUiSelectors" -}}
{{- if .Values.global.enterprise }}
{{- if .Values.graphUi.selectors -}}
{{ .Values.graphUi.selectors | toYaml }}
{{- else -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: graph-ui
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "core-mesh.searchApiSelectors" -}}
{{- if .Values.global.enterprise }}
{{- if .Values.searchApi.selectors -}}
{{ .Values.searchApi.selectors | toYaml }}
{{- else -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: smart-cache-search-api
{{- end -}}
{{- end -}}
{{- end -}}

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
