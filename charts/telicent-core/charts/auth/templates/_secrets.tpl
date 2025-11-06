{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the elastic / opensearch secret
*/}}
{{- define "auth.externalIdpSecretName" -}}
{{- if .Values.externalIdpSecret.existingSecret }}
{{- .Values.externalIdpSecret.existingSecret }}
{{- else }}
{{- printf "%s-tc-auth-usr-%s" (include "auth.fullname" .) "external-idp" }}
{{- end }}
{{- end -}}

{{/*
Create the name of the elastic / opensearch secret
*/}}
{{- define "auth.postgresSecretName" -}}
{{- if .Values.postgresSecret.existingSecret }}
{{- .Values.postgresSecret.existingSecret }}
{{- else }}
{{- printf "%s-tc-auth-usr-%s" (include "auth.fullname" .) "postgres" }}
{{- end }}
{{- end -}}
