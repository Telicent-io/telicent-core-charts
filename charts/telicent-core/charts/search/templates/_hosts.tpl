{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
This file contains the names of other host/service name(s) and service account name(s) on which this
application relies on. For a full explanation please view '_hosts.tlp' file in the 'auth' sub-chart.
*/}}

{{/*
------------------------------ Start boiler plate ------------------------------
Returns the service/serviceAccount with or without a release name.
Note: Dev team - only the function prefix ("search.") and the references should be updated when copied into other sub-charts.
*/}}
{{- define "search.discoverService" -}}
{{- $envVal := index . 0 -}}
{{- $serviceVal := index . 1 -}}
{{- $name := default $envVal.Chart.Name $envVal.Values.nameOverride -}}
{{- if or (contains $name $envVal.Release.Name) ( eq ($envVal.Values.hosts.enableAutoConfigure) false) -}}
{{- printf "%s" $serviceVal -}}
{{- else -}}
{{- printf "%s-%s" $envVal.Release.Name $serviceVal -}}
{{- end -}}
{{- end -}}
{{/*
Returns the host value in the format service:port
*/}}
{{- define "search.discoverHost" -}}
{{- $envVal := index . 0 -}}
{{- $hostVal := index . 1 -}}
{{- if not $envVal.Values.hosts.enableAutoCorrect -}}
{{- printf "%s" $hostVal -}}
{{- else -}}
{{- $name := (index (splitList ":" $hostVal) 0 ) -}}
{{- $port := (index (splitList ":" $hostVal) 1 | default 8080 ) -}}
{{- printf "%s.%s:%s" (include "search.discoverService" (list $envVal $name)) $envVal.Release.Namespace $port -}}
{{- end -}}
{{- end -}}
{{/*
Returns the *external* host value in the format service:port
*/}}
{{- define "search.discoverHostExternal" -}}
{{- $hostVal := index . 1 -}}
{{- printf "%s" $hostVal -}}
{{- end -}}
{{/*
Returns the serviceAccount value
*/}}
{{- define "search.discoverServiceAccount" -}}
{{- $envVal := index . 0 -}}
{{- $hostVal := index . 1 -}}
{{- $name := (index (splitList ":" $hostVal) 0 ) -}}
{{- if not $envVal.Values.hosts.enableAutoCorrect -}}
{{- printf "%s" $name -}}
{{- else -}}
{{- printf "%s" (include "search.discoverService" (list $envVal $name)) -}}
{{- end -}}
{{- end -}}
{{/*
Returns the *external* serviceAccount value
*/}}
{{- define "search.discoverServiceAccountExternal" -}}
{{- $hostVal := index . 1 -}}
{{- printf "%s" (index (splitList ":" $hostVal) 0 ) -}}
{{- end -}}
{{/*
------------------------------ End boiler plate ------------------------------
*/}}

{{/*
auth - returns host ('service:port') and serviceAccount
*/}}
{{- define "search.hostAuth" -}}
{{- printf "%s" (include "search.discoverHost" (list . .Values.hosts.auth )) -}}
{{- end -}}
{{- define "search.serviceAccountAuth" -}}
{{- printf "%s" (include "search.discoverServiceAccount" (list . .Values.hosts.auth )) -}}
{{- end -}}

{{/*
traefik-proxy - returns host ('service:port') and serviceAccount
*/}}
{{- define "search.hostTraefikProxy" -}}
{{- printf "%s" (include "search.discoverHost" (list . .Values.hosts.traefikProxy )) -}}
{{- end -}}
{{- define "search.serviceAccountTraefikProxy" -}}
{{- printf "%s" (include "search.discoverServiceAccount" (list . .Values.hosts.traefikProxy )) -}}
{{- end -}}

{{/*
graph - returns host ('service:port') and serviceAccount
*/}}
{{- define "search.hostGraph" -}}
{{- printf "%s" (include "search.discoverHost" (list . .Values.hosts.graph )) -}}
{{- end -}}
{{- define "search.serviceAccountGraph" -}}
{{- printf "%s" (include "search.discoverServiceAccount" (list . .Values.hosts.graph )) -}}
{{- end -}}
