{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of the config map
*/}}
{{- define "access.envConfigmapName" -}}
{{- if .Values.existingConfigmap }}
{{- .Values.existingConfigmap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "env" }}
{{- end }}
{{- end }}

{{/*
Create the name of the CA config map
*/}}
{{- define "access.cacertConfigmapName" -}}
{{- if .Values.existingCacertConfigmap -}}
{{- .Values.existingCacertConfigmap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "cacert" }}
{{- end }}
{{- end }}

