{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Create the name of the PostgreSQL secret
*/}}
{{- define "notifications-projector.postgresSecretName" -}}
{{- if .Values.postgres.existingSecret }}
{{- .Values.postgres.existingSecret }}
{{- else }}
{{- printf "%s-postgresql" (include "notifications-projector.fullname" .) }}
{{- end }}
{{- end -}}
