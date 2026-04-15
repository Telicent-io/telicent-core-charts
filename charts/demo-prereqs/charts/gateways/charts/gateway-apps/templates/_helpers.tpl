{{/*
Copyright (C) 2025-2026 Telicent Limited
*/}}

{{/*
Trim the chart name prefix
*/}}
{{- define "gateway-apps.ChartShortName" -}}
{{- .Chart.Name | trimPrefix "gateway-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "gateway-apps.name" -}}
{{- default (include "gateway-apps.ChartShortName" .) .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gateway-apps.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (include "gateway-apps.ChartShortName" .) .Values.nameOverride }}
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
{{- define "gateway-apps.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gateway-apps.labels" -}}
helm.sh/chart: {{ include "gateway-apps.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Jwks URI
*/}}
{{- define "gateway-apps.jwksUri" -}}
{{- if .Values.jwksUri -}}
{{- .Values.jwksUri -}}
{{- else -}}
{{- printf "https://%s/realms/master/protocol/openid-connect/certs" .Values.global.idpHost -}}
{{- end -}}
{{- end -}}
{{/*
JWT Issuer
*/}}
{{- define "gateway-apps.jwtIssuer" -}}
{{- if .Values.jwtIssuer -}}
{{- .Values.jwtIssuer -}}
{{- else -}}
{{- printf "https://%s/realms/master" .Values.global.idpHost -}}
{{- end -}}
{{- end -}}

{{/*
Apps TLS credential name
*/}}
{{- define "gateway-apps.tlsCredentialName" -}}
{{- if .Values.tls.existingCredentialName -}}
{{- .Values.tls.existingCredentialName -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "apps-tls" -}}
{{- end -}}
{{- end -}}
