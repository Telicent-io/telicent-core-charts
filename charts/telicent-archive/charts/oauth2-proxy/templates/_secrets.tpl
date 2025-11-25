{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the IDP secret
*/}}
{{- define "oauth2-proxy.idpSecretName" -}}
{{- if .Values.idp.existingSecret }}
{{- .Values.idp.existingSecret }}
{{- else }}
{{- printf "tc-auth-gen-%s-%s" "idp" .Chart.Name  }}
{{- end }}
{{- end -}}

{{/*
Create the name of ca secret, the name will be empty when no CA has been provided
*/}}
{{- define "oauth2-proxy.caSecretName" -}}
{{- if .Values.tls.ca.existingSecret }}
{{- .Values.tls.ca.existingSecret }}
{{- else if .Values.tls.ca.certificate }}
{{- printf "tc-auth-ca-%s" "root" .Chart.Name }}
{{- end }}
{{- end -}}
