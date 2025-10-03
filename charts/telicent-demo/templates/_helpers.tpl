{{/*
Generate a random password for Kafka users: smart-cache and pipeline.
*/}}
{{- define "telicent-demo.kafkaSmartCachePassword" -}}
{{- randAlphaNum 24 | b64enc -}}
{{- end -}}

{{- define "telicent-demo.kafkaPipelinePassword" -}}
{{- randAlphaNum 24 | b64enc -}}
{{- end -}}

{{/*
Generate a random password for MongoDB user: user-preferences, access, and admin
*/}}
{{- define "telicent-demo.mongoUserPreferencesPassword" -}}
{{- randAlphaNum 24 | b64enc -}}
{{- end -}}

{{- define "telicent-demo.mongoAccessPassword" -}}
{{- randAlphaNum 24 | b64enc -}}
{{- end -}}

{{- define "telicent-demo.mongoAdminPassword" -}}
{{- randAlphaNum 24 | b64enc -}}
{{- end -}}
