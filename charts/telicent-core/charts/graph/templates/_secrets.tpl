{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{- define "graph.envSecretName" -}}
{{ include "graph.fullname" . }}
{{- end }}
