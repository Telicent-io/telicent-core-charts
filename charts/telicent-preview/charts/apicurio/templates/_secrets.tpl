{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Create the name of the PostgreSQL secret
*/}}
{{- define "apicurio.postgresSecretName" -}}
{{- if .Values.postgres.existingSecret }}
{{- .Values.postgres.existingSecret }}
{{- else }}
{{- printf "tc-auth-usr-%s-%s" "psql" .Chart.Name }}
{{- end }}
{{- end -}}

{{/*
Create the name of the OIDC client secret
*/}}
{{- define "apicurio.oidcClientSecretName" -}}
{{- if .Values.config.oidcExistingSecret }}
{{- .Values.config.oidcExistingSecret }}
{{- else }}
{{- printf "tc-auth-gen-apicurio-registry-api" }}
{{- end }}
{{- end -}}
