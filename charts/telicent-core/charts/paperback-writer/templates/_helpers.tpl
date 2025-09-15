{{/*
Expand the name of the chart.
*/}}
{{- define "paperback-writer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "paperback-writer.fullname" -}}
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
{{- define "paperback-writer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "paperback-writer.labels" -}}
helm.sh/chart: {{ include "paperback-writer.chart" . }}
{{ include "paperback-writer.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "paperback-writer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "paperback-writer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "paperback-writer.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "paperback-writer.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the Sparql endpoint URL
*/}}
{{- define "paperback-writer.sparqlEndpoint" -}}
{{- if .Values.configuration.sparqlUrl }}
{{- .Values.configuration.sparqlUrl }}
{{- else }}
{{- printf "http://%s-graph.%s.svc.cluster.local:3030" (.Release.Name) (.Release.Namespace) }}
{{- end }}
{{- end }}

{{/*
Create the Access endpoint URL
*/}}
{{- define "paperback-writer.accessApiEndpoint" -}}
{{- if .Values.configuration.accessApiUrl }}
{{- .Values.configuration.accessApiUrl }}
{{- else }}
{{- printf "http://%s-access.%s.svc.cluster.local:8080" (.Release.Name) (.Release.Namespace) }}
{{- end }}
{{- end }}

{{/*
Create ConfigMapName
*/}}
{{- define "paperback-writer.configMapName" -}}
{{- if .Values.existingConfigMapName }}
{{- .Values.existingConfigMapName }}
{{- else }}
{{- printf "%s-config" (include "paperback-writer.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Create ConfigMapName
*/}}
{{- define "paperback-writer.secretName" -}}
{{- if .Values.existingSecretName }}
{{- .Values.existingSecretName }}
{{- else }}
{{- printf "%s-secret" (include "paperback-writer.fullname" .) }}
{{- end }}
{{- end }}

{{- define "paperback-writer.ingressPrincipal" -}}
{{- .Values.istio.ingress.principal | default (printf "cluster.local/ns/%s/sa/%s" .Values.global.istioNamespace .Values.global.istioServiceAccountName) | quote }}
{{- end }}
