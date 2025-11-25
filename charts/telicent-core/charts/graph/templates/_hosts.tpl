{{/*
Copyright (C) 2025 Telicent Limited
*/}}

{{/*
This file contains dependant host/service name(s) on which this application relies on.
*/}}

{{/*
Returns the host/service name
a.) when installed through the parent chart, the host/service name will include the release name.
b.) when installed through a sub chart, where release name equals 'graph' (chart name) the
    release name will not be included in the host/service name
*/}}

*/}}
{{- define "graph.searchUrl" -}}
{{- printf "http://search:8080" }}
{{- end }}
