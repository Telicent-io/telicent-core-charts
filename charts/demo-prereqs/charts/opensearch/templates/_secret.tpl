{{/*
Copyright (C) 2025-2026 Telicent Limited
*/}}

{{- define "opensearch-deps.secretName" -}}
{{- if .Values.secret.name }}
{{- .Values.secret.name }}
{{- else }}
{{- include "opensearch-deps.fullname" . }}
{{- end }}
{{- end }}

{{- define "opensearch-deps.secretData" -}}
_meta:
  type: "internalusers"
  config_version: 2

{{ .Values.secret.adminUserName }}:
  hash: {{ .Values.secret.adminUserPassword | quote }}
  reserved: true
  backend_roles:
    - "admin"
  description: {{ printf "%s user" .Values.secret.adminUserName | quote }}

{{ .Values.secret.userName }}:
  hash: {{ .Values.secret.userPassword | quote }}
  reserved: true
  backend_roles:
    - "admin"
  description: {{ printf "%s user" .Values.secret.userName | quote }}
{{- end }}
