{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the external IDP secret
*/}}
{{- define "auth.externalIdpSecretName" -}}
{{- if .Values.externalIdp.existingSecret }}
{{- .Values.externalIdp.existingSecret }}
{{- else }}
{{- printf "%s-tc-auth-usr-%s" (include "auth.fullname" .) "external-idp" }}
{{- end }}
{{- end -}}

{{/*
Create the name of the ForwardAuth secret
*/}}
{{- define "auth.forwardAuthSecretName" -}}
{{- if .Values.forwardAuth.existingSecret }}
{{- .Values.forwardAuth.existingSecret }}
{{- else }}
{{- printf "%s-tc-auth-usr-%s" (include "auth.fullname" .) "forward-auth" }}
{{- end }}
{{- end -}}

{{/*
Create the name of the PostgreSQL secret
*/}}
{{- define "auth.postgresSecretName" -}}
{{- if .Values.postgres.existingSecret }}
{{- .Values.postgres.existingSecret }}
{{- else }}
{{- printf "%s-tc-auth-usr-%s" (include "auth.fullname" .) "postgres" }}
{{- end }}
{{- end -}}
