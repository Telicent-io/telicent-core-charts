{{/*

This template does not define anything, instead it contains conditional statements that are validated during install to ensure dependent values are provided.

*/}}

{{- if .Values.strimziOperator.enabled -}}
    {{- if and (not .Values.strimziOperator.sourcePrincipal ) (not .Values.strimziOperator.namespace  ) (not .Values.strimziOperator.kafkaClusterName  ) -}}
        When Strimzi Operator is enabled, we need to know the source principal and namespace it is installed in to ensure we grant access via Istio to the controller for topic and user management.
        Installation of the Strimzi Operator is not part of this helm chart.
    {{- end -}}
{{- end -}}