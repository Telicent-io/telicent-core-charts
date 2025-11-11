{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of oauth secret
*/}}
{{- define "oauth2-proxy.oauthSecretName" -}}
{{- if .Values.oauthClientSecret.existingSecret }}
{{- .Values.oauthClientSecret.existingSecret }}
{{- else }}
{{- printf "%s-tc-auth-gen-%s" (include "oauth2-proxy.fullname" .) "oauth" }}
{{- end }}
{{- end -}}

{{/*
Create the name of ca secret, the name will be empty when no CA has been provided
*/}}
{{- define "oauth2-proxy.caSecretName" -}}
{{- if .Values.tls.ca.existingSecret }}
{{- .Values.tls.ca.existingSecret }}
{{- else if .Values.tls.ca.certificate }}
{{- printf "%s-tc-auth-ca-%s" (include "oauth2-proxy.fullname" .) "root" }}
{{- end }}
{{- end -}}
