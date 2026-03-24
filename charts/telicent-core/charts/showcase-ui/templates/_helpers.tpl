{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "showcase-ui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Allow the release namespace to be overridden.
*/}}
{{- define "showcase-ui.namespace" -}}
{{- if .Values.namespaceOverride -}}
{{- .Values.namespaceOverride -}}
{{- else -}}
{{- .Release.Namespace -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "showcase-ui.fullname" -}}
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
{{- define "showcase-ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "showcase-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "showcase-ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "showcase-ui.labels" -}}
helm.sh/chart: {{ include "showcase-ui.chart" . }}
{{ include "showcase-ui.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ include "showcase-ui.version" . | quote }}
app: {{ include "showcase-ui.name" . }}
telicent.io/resource: "true"
{{- range $key, $value := .Values.commonLabels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use (based on the fullname).
*/}}
{{- define "showcase-ui.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "showcase-ui.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- .Values.serviceAccount.name | default "default" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service to use (based on the fullname).
*/}}
{{- define "showcase-ui.serviceName" -}}
{{- if .Values.service.name }}
{{- .Values.service.name -}}
{{- else }}
{{- include "showcase-ui.fullname" . }}
{{- end }}
{{- end }}
