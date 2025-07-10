{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{- define "telicent-core.kafka-config-properties" -}}
      security.protocol={{ .Values.global.kafkaConfigProtocol }}
      sasl.mechanism={{ .Values.global.kafkaConfigMechanism }}
      {{- if eq .Values.global.kafkaConfigMechanism "SCRAM-SHA-512" }}
      sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
      {{- else if eq .Values.global.kafkaConfigMechanism "PLAIN" }}
      sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required \
      {{- end }}
        username={{ .Values.global.kafkaConfigUsername | quote }} \
        password={{ .Values.global.kafkaConfigPassword | quote }};
{{- end  -}}

{{- define "telicent-core.kafka-config-toml" -}}
bootstrap.servers={{ .Values.global.kafkaBootstrapUrls }}
security.protocol={{ .Values.global.kafkaConfigProtocol }}
sasl.mechanism={{ .Values.global.kafkaConfigMechanism }}
sasl.username={{ .Values.global.kafkaConfigUsername | replace "\"" "" }}
sasl.password={{ .Values.global.kafkaConfigPassword | replace "\"" "" }}
{{- end  -}}

{{- define "telicent-core.application-properties" -}}
      camel.component.kafka.security-protocol={{ .Values.global.kafkaConfigProtocol }}
      camel.component.kafka.sasl-mechanism={{ .Values.global.kafkaConfigMechanism }}
      {{- if eq .Values.global.kafkaConfigMechanism "SCRAM-SHA-512" }}
      camel.component.kafka.sasl-jaas-config=org.apache.kafka.common.security.scram.ScramLoginModule required \
      {{- else if eq .Values.global.kafkaConfigMechanism "PLAIN" }}
      camel.component.kafka.sasl-jaas-config=org.apache.kafka.common.security.plain.PlainLoginModule required \
      {{- end }}
        username={{ .Values.global.kafkaConfigUsername | quote }} \
        password={{ .Values.global.kafkaConfigPassword | quote }};
{{- end  -}}

