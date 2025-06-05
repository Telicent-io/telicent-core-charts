{{/*
Trim the chart name prefix
*/}}
{{- define "gateways.ChartShortName" -}}
{{- .Chart.Name | trimPrefix "demo-prereqs-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "gateways.name" -}}
{{- default (include "gateways.ChartShortName" .) .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gateways.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (include "gateways.ChartShortName" .) .Values.nameOverride }}
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
{{- define "gateways.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gateways.labels" -}}
helm.sh/chart: {{ include "gateways.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Jwks URI
*/}}
{{- define "gateways.jwksUri" -}}
{{- if .Values.jwksUri -}}
{{- .Values.jwksUri -}}
{{- else -}}
{{- printf "https://%s/realms/master/protocol/openid-connect/certs" .Values.authnHost -}}
{{- end -}}
{{- end -}}
{{/*
JWT Issuer
*/}}
{{- define "gateways.jwtIssuer" -}}
{{- if .Values.jwtIssuer -}}
{{- .Values.jwtIssuer -}}
{{- else -}}
{{- printf "https://%s/realms/master" .Values.authnHost -}}
{{- end -}}
{{- end -}}

{{/*
Apps TLS credential name
*/}}
{{- define "gateways.appsTlsCredentialName" -}}
{{- if .Values.appsTlsCredentialName -}}
{{- .Values.appsTlsCredentialName -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "apps-tls" -}}
{{- end -}}
{{- end -}}

{{/*
Auth TLS credential name
*/}}
{{- define "gateways.authnTlsCredentialName" -}}
{{- if .Values.authnTlsCredentialName -}}
{{- .Values.authnTlsCredentialName -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "authn-tls" -}}
{{- end -}}
{{- end -}}

{{- define "gateways.customAuthzProviderName" -}}
{{- printf "%s-%s" "oauth2-proxy-apps" .Values.tenantName -}}
{{ end }}