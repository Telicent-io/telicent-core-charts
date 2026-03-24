{{/*
Copyright (C) 2026 Telicent Limited
*/}}

{{/*
Returns the version
*/}}
{{- define "showcase-ui.version" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{/*
Returns the image registry
*/}}
{{- define "showcase-ui.imageRegistry" -}}
{{- .Values.global.imageRegistry | default .Values.image.registry }}
{{- end -}}

{{/*
Returns the image 
*/}}
{{- define "showcase-ui.image" -}}
{{- printf "%s/%s:%s" (include "showcase-ui.imageRegistry" .) .Values.image.repository  (include "showcase-ui.version" .) }}
{{- end -}}
