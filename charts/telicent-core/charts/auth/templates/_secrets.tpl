{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the PostgreSQL secret
*/}}
{{- define "auth.postgresSqlSecretName" -}}
{{- if .Values.postgresSql.existingSecret }}
{{- .Values.postgresSql.existingSecret }}
{{- else }}
{{- printf "tc-auth-usr-%s-%s" "psql" .Chart.Name }}
{{- end }}
{{- end -}}

{{/*
Create the name of the IDP secret
*/}}
{{- define "auth.idpSecretName" -}}
{{- if .Values.idp.existingSecret }}
{{- .Values.idp.existingSecret }}
{{- else }}
{{- printf "tc-auth-gen-%s-%s" "idp" .Chart.Name  }}
{{- end }}
{{- end -}}

{{/*
Create the name of the ForwardAuth secret
*/}}
{{- define "auth.forwardAuthSecretName" -}}
{{- if .Values.forwardAuth.existingSecret }}
{{- .Values.forwardAuth.existingSecret }}
{{- else }}
{{- printf "tc-auth-gen-%s-%s" "forward" .Chart.Name }}
{{- end }}
{{- end -}}
