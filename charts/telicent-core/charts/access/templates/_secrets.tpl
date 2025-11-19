{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of mongo secret
*/}}
{{- define "access.mongoSecretName" -}}
{{- if .Values.mongo.existingSecret }}
{{- .Values.mongo.existingSecret }}
{{- else }}
{{- printf "tc-auth-usr-%s-%s" "mongo" .Chart.Name }}
{{- end }}
{{- end -}}

