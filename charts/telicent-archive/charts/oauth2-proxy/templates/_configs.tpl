{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
Create the name of oauth2 proxy env config map 
*/}}
{{- define "oauth2-proxy.envConfigMapName" -}}
{{- if .Values.configMap.existingEnvConfigMap }}
{{- .Values.configMap.existingEnvConfigMap }}
{{- else }}
{{- printf "tc-%s-%s" .Chart.Name "env" }}
{{- end }}
{{- end -}}

{{/*
Create the oidcRedirectURL
*/}}
{{- define "oauth2-proxy.oidcRedirectUrl" -}}
{{- if .Values.oauth.redirectUrl }}
{{- .Values.oauth.redirectUrl }}
{{- else }}
{{- printf "https://%s/oauth2/callback" .Values.global.authHostDomain }}
{{- end }}
{{- end }}
