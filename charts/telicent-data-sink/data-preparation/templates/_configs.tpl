{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Create the name of the environment config map (based on the fullname).
*/}}
{{- define "data-preparation.envConfigMapName" -}}
{{- if .Values.configMap.existingEnvConfigMapName }}
{{- .Values.configMap.existingEnvConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" (include "data-preparation.fullname" .) "env" }}
{{- end }}
{{- end }}

{{/*
Create the name of the engine config map (based on the fullname).
*/}}
{{- define "data-preparation.engineConfigMapName" -}}
{{- printf "tc-%s-%s" (include "data-preparation.fullname" .) "eng" }}
{{- end }}
