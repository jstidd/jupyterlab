{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "jupyterlab.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jupyterlab.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "jupyterlab.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
postgres host
*/}}
{{- define "postgres-host" -}}
{{- $url := printf "%s-postgresql.%s.svc.cluster.local" .Release.Name .Release.Namespace -}}
{{- printf "postgres+psycopg2://postgres:%s@%s:5432/jupyter" .Values.global.postgresPassword $url -}}
{{- end -}}

{{/*
postgres password
*/}}
{{- define "postgres-password" -}}
{{- printf "%s" .Values.global.postgresPassword | b64enc -}}
{{- end -}}

{{/*
postgres string
*/}}
{{- define "postgres-string" -}}
{{- printf "postgres+psycopg2://root:%s@%s:5432/%s" "postgres-password" "postgres-host" .Values.postgresql.postgresqlDatabase -}}
{{- end -}}
