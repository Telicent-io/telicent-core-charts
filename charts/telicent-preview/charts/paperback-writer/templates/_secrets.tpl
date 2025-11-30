{{/*
Copyright (C) 2025 Telicent Limited
*/}}


{{- define "paperback-writer.secretName" -}}
{{- if .Values.existingSecretName }}
{{- .Values.existingSecretName }}
{{- else }}
{{- printf "tc-auth-usr-%s-%s" "sparql" .Chart.Name }}
{{- end }}
{{- end }}
