{{/*
Expand the name of the chart.
*/}}
{{- define "keycloak-realm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "keycloak-realm.fullname" -}}
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
Chart name and version as used by the chart label.
*/}}
{{- define "keycloak-realm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "keycloak-realm.labels" -}}
helm.sh/chart: {{ include "keycloak-realm.chart" . }}
{{ include "keycloak-realm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "keycloak-realm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "keycloak-realm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Name of the ServiceAccount to use.
*/}}
{{- define "keycloak-realm.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "keycloak-realm.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Resolved image tag (defaults to the chart appVersion).
*/}}
{{- define "keycloak-realm.imageTag" -}}
{{- default .Chart.AppVersion .Values.image.tag }}
{{- end }}

{{/*
Name of the Secret holding the Keycloak admin credentials. Uses the existing
Secret when provided, otherwise the chart-managed "<fullname>-env" Secret.
*/}}
{{- define "keycloak-realm.envSecretName" -}}
{{- if .Values.keycloak.existingSecret -}}
{{- .Values.keycloak.existingSecret -}}
{{- else -}}
{{- printf "%s-%s" (include "keycloak-realm.fullname" .) "env" -}}
{{- end -}}
{{- end -}}
