{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the config map
*/}}
{{- define "graph-ui.configMapName" -}}
{{- printf "tc-%s-%s" .Chart.Name "env-configjs" }}
{{- end }}
