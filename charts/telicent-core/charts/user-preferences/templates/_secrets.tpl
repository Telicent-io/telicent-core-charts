{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of mongo secret
*/}}
{{- define "user-preferences.mongoSecretName" -}}
{{- if .Values.mongo.existingSecret }}
{{- .Values.mongo.existingSecret }}
{{- else }}
{{- printf "%s-tc-auth-usr-%s" (include "user-preferences.fullname" .) "mongo" }}
{{- end }}
{{- end -}}
