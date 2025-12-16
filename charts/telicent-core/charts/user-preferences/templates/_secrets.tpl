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
{{- printf "tc-auth-usr-%s-%s" "mongo" .Chart.Name }}
{{- end }}
{{- end -}}

{{/* 
Create MongoPassword name to use
*/}}
{{- define "user-preferences.secret" -}}
{{ include "user-preferences.fullname" . }}-secret
{{- end }}
