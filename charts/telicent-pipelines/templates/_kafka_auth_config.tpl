{{- define "telicent-pipelines.kafka-config-properties" -}}
      security.protocol={{ .Values.kafkaConfigProtocol }}
      sasl.mechanism={{ .Values.kafkaConfigMechanism }}
      {{- if eq .Values.kafkaConfigMechanism "SCRAM-SHA-512" }}
      sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
      {{- else if eq .Values.kafkaConfigMechanism "PLAIN" }}
      sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required \
      {{- end }}
        username={{ .Values.kafkaConfigUsername | quote }} \
        password={{ .Values.kafkaConfigPassword | quote }};
{{- end  -}}

{{- define "telicent-pipelines.kafka-config-toml" -}}
bootstrap.servers={{ .Values.kafkaBootstrapUrls }}
security.protocol={{ .Values.kafkaConfigProtocol }}
sasl.mechanism={{ .Values.kafkaConfigMechanism }}
sasl.username={{ .Values.kafkaConfigUsername | replace "\"" "" }}
sasl.password={{ .Values.kafkaConfigPassword | replace "\"" "" }}
{{- end  -}}

{{- define "telicent-pipelines.application-properties" -}}
      camel.component.kafka.security-protocol={{ .Values.kafkaConfigProtocol }}
      camel.component.kafka.sasl-mechanism={{ .Values.kafkaConfigMechanism }}
      {{- if eq .Values.kafkaConfigMechanism "SCRAM-SHA-512" }}
      camel.component.kafka.sasl-jaas-config=org.apache.kafka.common.security.scram.ScramLoginModule required \
      {{- else if eq .Values.kafkaConfigMechanism "PLAIN" }}
      camel.component.kafka.sasl-jaas-config=org.apache.kafka.common.security.plain.PlainLoginModule required \
      {{- end }}
        username={{ .Values.kafkaConfigUsername | quote }} \
        password={{ .Values.kafkaConfigPassword | quote }};
{{- end  -}}
