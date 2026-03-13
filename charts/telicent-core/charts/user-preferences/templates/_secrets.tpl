{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Create the name of the MongoDB secret
*/}}
{{- define "user-preferences.mongoSecretName" -}}
{{- if .Values.mongo.existingSecret }}
{{- .Values.mongo.existingSecret }}
{{- else }}
{{- printf "tc-auth-usr-%s-%s" "mongo" .Chart.Name }}
{{- end }}
{{- end -}}

{{/*
Create the name of the PostgreSQL secret
*/}}
{{- define "user-preferences.postgresSecretName" -}}
{{- if .Values.postgres.existingSecret }}
{{- .Values.postgres.existingSecret }}
{{- else }}
{{- printf "tc-auth-usr-%s-%s" "psql" .Chart.Name }}
{{- end }}
{{- end -}}
