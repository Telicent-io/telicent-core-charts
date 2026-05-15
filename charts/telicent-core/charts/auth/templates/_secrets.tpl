{{/*
Copyright (C) 2026 Telicent Limited
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

{{/*
Create the name of the notifications client secret
*/}}
{{- define "auth.notificationsClientSecretName" -}}
{{- if .Values.bootstrap.clients.notifications.existingSecret }}
{{- .Values.bootstrap.clients.notifications.existingSecret }}
{{- else }}
{{- printf "tc-auth-gen-notifications-api" }}
{{- end }}
{{- end -}}

{{/*
Create the name of the registry client secret
*/}}
{{- define "auth.registryClientSecretName" -}}
{{- if .Values.bootstrap.clients.registry.existingSecret }}
{{- .Values.bootstrap.clients.registry.existingSecret }}
{{- else }}
{{- printf "tc-auth-gen-apicurio-registry-api" }}
{{- end }}
{{- end -}}
