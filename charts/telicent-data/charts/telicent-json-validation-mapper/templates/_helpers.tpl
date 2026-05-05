{{/*
Expand the name of the chart.
*/}}
{{- define "json-validation-mapper.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "json-validation-mapper.fullname" -}}
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
{{- define "json-validation-mapper.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "json-validation-mapper.labels" -}}
helm.sh/chart: {{ include "json-validation-mapper.chart" . }}
{{ include "json-validation-mapper.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
telicent.io/type: mapper
telicent.io/component-of: {{ .Values.configuration.componentOf}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "json-validation-mapper.selectorLabels" -}}
app.kubernetes.io/name: {{ include "json-validation-mapper.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Validate that exactly one schema source is configured.
Either schema.existingConfigMapName, or both schema.name and schema.content must be set — not both.
*/}}
{{- define "json-validation-mapper.validateSchema" -}}
{{- if and .Values.schema.existingConfigMapName .Values.schema.name -}}
{{- fail "schema.existingConfigMapName and schema.name are mutually exclusive. Use one or the other." -}}
{{- end -}}
{{- if not .Values.schema.existingConfigMapName -}}
{{- if not .Values.schema.name -}}
{{- fail "Either schema.existingConfigMapName or schema.name (with schema.content) must be set." -}}
{{- end -}}
{{- if not .Values.schema.content -}}
{{- fail "schema.content is required when schema.name is set. Provide the raw JSON schema content." -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Return the name of the schema ConfigMap to mount.
*/}}
{{- define "json-validation-mapper.schemaConfigMapName" -}}
{{- if .Values.schema.existingConfigMapName -}}
{{- .Values.schema.existingConfigMapName -}}
{{- else -}}
{{- include "json-validation-mapper.fullname" . }}-schema
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "json-validation-mapper.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "json-validation-mapper.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
