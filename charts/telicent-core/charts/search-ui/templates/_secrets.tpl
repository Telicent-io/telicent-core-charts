{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the config secret
todo: refactor deployment to use secret
*/}}
{{- define "search-ui.configSecretName" -}}
{{- printf "tc-auth-gen-%s-%s" "config-js" .Chart.Name }}
{{- end }}
