{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "flux.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "flux.labels" -}}
helm.sh/chart: {{ include "flux.chart" . }}
app.kubernetes.io/instance: flux-system
app.kubernetes.io/part-of: flux
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}