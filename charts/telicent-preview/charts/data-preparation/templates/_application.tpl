{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Renders application.properties content for a data-preparation instance.

Usage: include "data-preparation.application-properties" (dict "instance" $instanceConfig "global" $.Values.global)
*/}}
{{- define "data-preparation.application-properties" -}}
#
# Data Preparation Engine - Configuration
#
# ── Core ────────────────────────────────────────────────────────────────

# Kafka Streams application ID
application.id={{ required "instance.applicationId is required" .instance.applicationId }}

# Kafka bootstrap servers
bootstrap.servers={{ .global.kafka.bootstrapServers }}

# Input topic to consume from
topic.input={{ required "instance.topicInput is required" .instance.topicInput }}

# Output topic to produce to
topic.output={{ required "instance.topicOutput is required" .instance.topicOutput }}

# Dead letter queue topic for failed messages
topic.deadletter={{ required "instance.topicDeadLetter is required" .instance.topicDeadLetter }}

# Path to Kafka SASL/SSL auth properties file
kafka.auth.filepath={{ .instance.kafkaAuthFilepath | default "" }}

# ── Filter ──────────────────────────────────────────────────────────────

# Filter type: "idh" or "header"
{{- if .instance.filterType }}
filter.type={{ .instance.filterType }}
{{- end }}

{{- if contains .instance.filterType "idh" }}

# ── IDH Filter Properties (filter.type=idh) ────────────────────────────

# IDH specification version
client.version={{ .instance.clientVersion | default "1.0" }}

# Space-separated nationality codes; empty = no restriction
client.nationality={{ .instance.clientNationality | default "" }}

# Security classification level
client.classification={{ required "instance.clientClassification is required" .instance.clientClassification }}

# Space-separated organisation codes; empty = no restriction
client.organisation={{ .instance.clientOrganisation | default "" }}

# Space-separated group names; empty = no restriction
client.group={{ .instance.clientGroup | default "" }}
{{- end }}

{{- if contains .instance.filterType "headers" }}
# ── Header Filter Properties (filter.type=header) ──────────────────────
{{- if .instance.headerFilters }}
{{- if .instance.headerFilters.include }}
{{- range $header, $value := .instance.headerFilters.include }}
header.filter.include.{{ $header }}={{ $value }}
{{- end }}
{{- end }}
{{- if .instance.headerFilters.exclude }}
{{- range $header, $value := .instance.headerFilters.exclude }}
header.filter.exclude.{{ $header }}={{ $value }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- if eq .instance.transformerType "distribution-id" }}
# ── Transformer ─────────────────────────────────────────────────────────

# Transformer type
transformer.type={{ .instance.transformerType | default "distribution-id" }}

# Distribution ID injected as a "Distribution-Id" Kafka header
distribution.id={{ required "instance.distributionId is required"  .instance.distributionId }}
{{- end }}
{{- end -}}
