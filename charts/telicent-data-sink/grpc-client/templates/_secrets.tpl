{{/*
Copyright (C) Telicent Limited
*/}}

{{/*
Create the name of the PostgreSQL secret
*/}}
{{- define "grpc-client.postgresSecretName" -}}
{{- if .Values.postgres.existingSecret }}
{{- .Values.postgres.existingSecret }}
{{- else }}
{{- printf "tc-auth-usr-%s-%s" "psql" .Chart.Name }}
{{- end }}
{{- end -}}
