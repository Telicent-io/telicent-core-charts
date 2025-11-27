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
Note: Dev team - only the function prefix ("graph.") and the references should be updated when copied into other sub-charts.
*/}}
{{- define "graph.discoverService" -}}
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
{{- define "graph.discoverHost" -}}
{{- $envVal := index . 0 -}}
{{- $hostVal := index . 1 -}}
{{- if not $envVal.Values.hosts.enableAutoCorrect -}}
{{- printf "%s" $hostVal -}}
{{- else -}}
{{- $name := (index (splitList ":" $hostVal) 0 ) -}}
{{- $port := (index (splitList ":" $hostVal) 1 | default 8080 ) -}}
{{- printf "%s.%s:%s" (include "graph.discoverService" (list $envVal $name)) $envVal.Release.Namespace $port -}}
{{- end -}}
{{- end -}}
{{/*
Returns the *external* host value in the format service:port
*/}}
{{- define "graph.discoverHostExternal" -}}
{{- $hostVal := index . 1 -}}
{{- printf "%s" $hostVal -}}
{{- end -}}
{{/*
Returns the serviceAccount value
*/}}
{{- define "graph.discoverServiceAccount" -}}
{{- $envVal := index . 0 -}}
{{- $hostVal := index . 1 -}}
{{- $name := (index (splitList ":" $hostVal) 0 ) -}}
{{- if not $envVal.Values.hosts.enableAutoCorrect -}}
{{- printf "%s" $name -}}
{{- else -}}
{{- printf "%s" (include "graph.discoverService" (list $envVal $name)) -}}
{{- end -}}
{{- end -}}
{{/*
Returns the *external* serviceAccount value
*/}}
{{- define "graph.discoverServiceAccountExternal" -}}
{{- $hostVal := index . 1 -}}
{{- printf "%s" (index (splitList ":" $hostVal) 0 ) -}}
{{- end -}}
{{/*
------------------------------ End boiler plate ------------------------------
*/}}

{{/*
auth - returns host ('service:port') and serviceAccount
*/}}
{{- define "graph.hostAuth" -}}
{{- printf "%s" (include "graph.discoverHost" (list . .Values.hosts.auth )) -}}
{{- end -}}
{{- define "graph.serviceAccountAuth" -}}
{{- printf "%s" (include "graph.discoverServiceAccount" (list . .Values.hosts.auth )) -}}
{{- end -}}

{{/*
traefik-proxy - returns host ('service:port') and serviceAccount
*/}}
{{- define "graph.hostTraefikProxy" -}}
{{- printf "%s" (include "graph.discoverHost" (list . .Values.hosts.traefikProxy )) -}}
{{- end -}}
{{- define "graph.serviceAccountTraefikProxy" -}}
{{- printf "%s" (include "graph.discoverServiceAccount" (list . .Values.hosts.traefikProxy )) -}}
{{- end -}}

{{/*
search - returns host ('service:port') and serviceAccount
*/}}
{{- define "graph.hostSearch" -}}
{{- printf "%s" (include "graph.discoverHost" (list . .Values.hosts.search )) -}}
{{- end -}}
{{- define "graph.serviceAccountSearch" -}}
{{- printf "%s" (include "graph.discoverServiceAccount" (list . .Values.hosts.search )) -}}
{{- end -}}

{{/*
paperback-writer *external* - returns host ('service:port') and serviceAccount
*/}}
{{- define "graph.hostPaperbackWriter" -}}
{{- printf "%s" (include "graph.discoverHostExternal" (list . .Values.hostsExternal.paperbackWriter )) -}}
{{- end -}}
{{- define "graph.serviceAccountPaperbackWriter" -}}
{{- printf "%s" (include "graph.discoverServiceAccountExternal" (list . .Values.hostsExternal.paperbackWriter )) -}}
{{- end -}}
