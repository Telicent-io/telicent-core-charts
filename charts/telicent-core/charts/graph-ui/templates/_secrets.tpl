{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the map config secret
*/}}
{{- define "graph-ui.mapSecretName" -}}
{{- if .Values.ui.existingMapConfigSecret }}
{{- .Values.ui.existingMapConfigSecret }}
{{- else }}
{{- printf "tc-auth-gen-%s-%s" "mapjs" .Chart.Name }}
{{- end }}
{{- end -}}
