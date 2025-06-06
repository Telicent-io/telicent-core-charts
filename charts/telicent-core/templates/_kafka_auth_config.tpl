{{- define "telicent-core.kafka-config-properties" -}}
      security.protocol={{ .Values.global.kafkaConfigProtocol | quote }}
      sasl.mechanism={{ .Values.global.kafkaConfigMechanism | quote }}
      {{- if eq .Values.global.kafkaConfigMechanism "SCRAM-SHA-512" }}
      sasl.jaas.config=sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
      {{ else if eq .Values.global.kafkaConfigMechanism "PLAIN" }}
      sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required \
      {{- end }}
        username={{ .Values.global.kafkaConfigUsername | quote }} \
        password={{ .Values.global.kafkaConfigPassword | quote }};
{{- end  -}}

{{- define "telicent-core.kafka-config-toml" -}}
      bootstrap.servers={{ .BOOTSTRAPSERVERS | toString }}
      security.protocol={{ .Values.global.kafkaConfigProtocol | quote }}
      sasl.mechanism={{ .Values.global.kafkaConfigMechanism | quote }}
      sasl.username={{ .Values.global.kafkaConfigUsername | quote }}
      sasl.password={{ .Values.global.kafkaConfigPassword | quote }}
{{- end  -}}

{{- define "telicent-core.application-properties" -}}
      camel.component.kafka.security-protocol={{ .Values.global.kafkaConfigProtocol | quote }}
      camel.component.kafka.sasl-mechanism={{ .Values.global.kafkaConfigMechanism | quote }}
      {{- if eq .Values.global.kafkaConfigMechanism "SCRAM-SHA-512" }}
      camel.component.kafka.sasl-jaas-config=org.apache.kafka.common.security.scram.ScramLoginModule required \
      {{ else if eq .Values.global.kafkaConfigMechanism "PLAIN" }}
      camel.component.kafka.sasl-jaas-config=org.apache.kafka.common.security.plain.PlainLoginModule required \
      {{- end }}
        username={{ .Values.global.kafkaConfigUsername | quote }} \
        password={{ .Values.global.kafkaConfigPassword | quote }};
{{- end  -}}

