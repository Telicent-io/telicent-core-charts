{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "document-pipeline.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Allow the release namespace to be overridden.
*/}}
{{- define "document-pipeline.namespace" -}}
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
{{- define "document-pipeline.fullname" -}}
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
{{- define "document-pipeline.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "document-pipeline.labels" -}}
helm.sh/chart: {{ include "document-pipeline.chart" . }}
telicent.io/resource: "true"
{{ include "document-pipeline.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "document-pipeline.selectorLabels" -}}
app.kubernetes.io/name: {{ include "document-pipeline.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "document-pipeline.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "document-pipeline.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
*********************
*** HTTP Ingestor ***
*********************
*/}}

{{/*
Fullname
*/}}

{{- define "http-ingester.fullname" -}}
{{ printf "%s-%s" (include "document-pipeline.fullname" .) "http-ingester"}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "http-ingester.selectorLabels" -}}
app.kubernetes.io/name: {{ include "document-pipeline.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: http-ingester
{{- end }}

{{/*
Common labels
*/}}
{{- define "http-ingester.labels" -}}
app.kubernetes.io/component: http-ingester
app: http-ingester
{{ include "document-pipeline.labels" . }}
{{- end }}

{{/*
*************************
*** Content Extractor ***
*************************
*/}}

{{/*
Fullname
*/}}

{{- define "content-extractor.fullname" -}}
{{ printf "%s-%s" (include "document-pipeline.fullname" .) "content-extractor"}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "content-extractor.selectorLabels" -}}
app.kubernetes.io/name: {{ include "document-pipeline.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: content-extractor
{{- end }}

{{/*
Common labels
*/}}
{{- define "content-extractor.labels" -}}
app.kubernetes.io/component: content-extractor
app: content-extractor
{{ include "document-pipeline.labels" . }}
{{- end }}

{{/*
***********************
*** Content Indexer ***
***********************
*/}}

{{/*
Fullname
*/}}

{{- define "content-indexer.fullname" -}}
{{ printf "%s-%s" (include "document-pipeline.fullname" .) "content-indexer"}}
{{- end }}

{{- define "content-indexer.name" -}}
{{ printf "%s-%s" (include "document-pipeline.name" .) "content-indexer"}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "content-indexer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "document-pipeline.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: content-indexer
{{- end }}

{{/*
Common labels
*/}}
{{- define "content-indexer.labels" -}}
app.kubernetes.io/component: content-indexer
app: content-indexer
{{ include "document-pipeline.labels" . }}
{{- end }}

{{/*
*************************
*** Catalogue Updater ***
*************************
*/}}

{{/*
Fullname
*/}}

{{- define "catalogue-updater.fullname" -}}
{{ printf "%s-%s" (include "document-pipeline.fullname" .) "catalogue-updater"}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "catalogue-updater.selectorLabels" -}}
app.kubernetes.io/name: {{ include "document-pipeline.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: catalogue-updater
{{- end }}

{{/*
Common labels
*/}}
{{- define "catalogue-updater.labels" -}}
app.kubernetes.io/component: catalogue-updater
app: catalogue-updater
{{ include "document-pipeline.labels" . }}
{{- end }}

{{/*
**********************
*** Content Tagger ***
**********************
*/}}

{{/*
Fullname
*/}}
{{- define "content-tagger.fullname" -}}
{{ printf "%s-%s" (include "document-pipeline.fullname" .) "content-tagger "}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "content-tagger.selectorLabels" -}}
app.kubernetes.io/name: {{ include "document-pipeline.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: content-tagger
{{- end }}

{{/*
Common labels
*/}}
{{- define "content-tagger.labels" -}}
app.kubernetes.io/component: content-tagger
app: content-tagger
{{ include "document-pipeline.labels" . }}
{{- end }}

{{/*
************************
*** Entity Extractor ***
************************
*/}}

{{/*
Fullname
*/}}
{{- define "entity-extractor.fullname" -}}
{{ printf "%s-%s" (include "document-pipeline.fullname" .) "entity-extractor" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "entity-extractor.selectorLabels" -}}
app.kubernetes.io/name: {{ include "document-pipeline.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: entity-extractor
{{- end }}

{{/*
Common labels
*/}}
{{- define "entity-extractor.labels" -}}
app.kubernetes.io/component: entity-extractor
app: entity-extractor
{{ include "document-pipeline.labels" . }}
{{- end }}
