{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Create the name of the ForwardAuth secret
*/}}
{{- define "traefik-proxy.forwardAuthSecretName" -}}
{{- if .Values.forwardAuth.existingSecret }}
{{- .Values.forwardAuth.existingSecret }}
{{- else }}
{{- printf "tc-auth-gen-%s-%s" "forward" .Chart.Name }}
{{- end }}
{{- end -}}
