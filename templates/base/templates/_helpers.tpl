{{/*
Expand the name of the chart.
*/}}
{{- define "base-chart.name" -}}
{{- default .Chart.Name .Values.app.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "base-chart.fullname" -}}
{{- $name := default .Chart.Name .Values.app.name }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "base-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "base-chart.labels" -}}
helm.sh/chart: {{ include "base-chart.chart" . }}
app.kubernetes.io/name: {{ include "base-chart.name" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "base-chart.selectorLabels" . }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "base-chart.annotations" -}}
creator: Two72DevOpsTeam
{{- end }}

{{/*
Selector labels
*/}}
{{- define "base-chart.selectorLabels" -}}
two72/app-name: {{ include "base-chart.name" . }}
two72/app-instance: {{ include "base-chart.name" . }}
two72/app-type: {{ .Values.app.type }}
two72/app-environment: {{ .Values.app.environment }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "base-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "base-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
