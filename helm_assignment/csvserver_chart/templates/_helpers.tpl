{{- define "prometheus_labels" }}
  app: prometheus
{{- end }}

{{- define "labels" }}
  app: {{ .Release.Name }}
{{- end }}
