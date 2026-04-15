{{/*
Copyright (C) 2025-2026 Telicent Limited
*/}}

{{/*
Trim the chart name prefix
*/}}
{{- define "kafka-ui-deps.ChartShortName" -}}
{{- .Chart.Name | trimPrefix "kafka-ui-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "kafka-ui-deps.name" -}}
{{- default (include "kafka-ui-deps.ChartShortName" .) .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kafka-ui-deps.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (include "kafka-ui-deps.ChartShortName" .) .Values.nameOverride }}
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
{{- define "kafka-ui-deps.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kafka-ui-deps.labels" -}}
helm.sh/chart: {{ include "kafka-ui-deps.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kafka-ui-deps.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kafka-ui-deps.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
TLS credential name
*/}}
{{- define "kafka-ui-deps.tlsCredentialName" -}}
{{- if .Values.ingress.certificateName -}}
{{- .Values.ingress.certificateName -}}
{{- else -}}
{{- printf "%s-%s" (include "kafka-ui-deps.fullname" .) "tls" -}}
{{- end -}}
{{- end -}}

{{/*
Gateway name
*/}}
{{- define "kafka-ui-deps.gatewayName" -}}
{{- if .Values.ingress.gatewayName -}}
{{- .Values.ingress.gatewayName -}}
{{- else -}}
{{- printf "%s-%s" "gateways" (include "kafka-ui-deps.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
JWKS URI
*/}}
{{- define "kafka-ui-deps.jwksUri" -}}
{{- if .Values.jwksUri -}}
{{- .Values.jwksUri -}}
{{- else -}}
{{- .Values.idp.jwksEndpoint -}}
{{- end -}}
{{- end -}}

{{/*
JWT Issuer URI
*/}}
{{- define "kafka-ui-deps.jwtIssuerUri" -}}
{{- if .Values.jwtIssuer -}}
{{- .Values.jwtIssuer -}}
{{- else -}}
{{- printf "https://%s/realms/core" .Values.idp.host -}}
{{- end -}}
{{- end -}}
