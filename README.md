# nestjs-metric

This is sample use prometheus with nestjs

use [nestjs-prometheus module](https://github.com/willsoto/nestjs-prometheus)

## create project

```shell=
nest new nestjs-metrics
```
## install related module

```shell=
yarn add @willsoto/nestjs-prometheus prom-client
```

## install with helm

```shell=
helm create nestjs-metrics
```

go to https://artifacthub.io/ find grafana and prothemeus

## setup chart
```yaml
apiVersion: v2
name: nestjs-metrics
description: A Helm chart for Kubernetes

# A chart can be either an 'application' or a 'library' chart.
#
# Application charts are a collection of templates that can be packaged into versioned archives
# to be deployed.
#
# Library charts provide useful utilities or functions for the chart developer. They're included as
# a dependency of application charts to inject those utilities and functions into the rendering
# pipeline. Library charts do not define any templates and therefore cannot be deployed.
type: application

# This is the chart version. This version number should be incremented each time you make changes
# to the chart and its templates, including the app version.
# Versions are expected to follow Semantic Versioning (https://semver.org/)
version: 0.1.0

# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application. Versions are not expected to
# follow Semantic Versioning. They should reflect the version the application is using.
# It is recommended to use it with quotes.
appVersion: "1.16.0"
dependencies:
  - name: prometheus
    version: '15.18.0'
    repository: 'https://prometheus-community.github.io/helm-charts'
  - name: grafana
    version: '6.43.5'
    repository: 'https://grafana.github.io/helm-charts'
```
## override default setup

```yaml
prometheus:
  alertmanager:
    enabled: false
  pushgateway:
    enabled: false
  nodeExporter:
    enabled: false

grafana:
  service:
    type: NodePort
```

## install

```shell
cd k8s/nestjs-metrics
helm dependency update
helm install nestjs-metrics .
```

## cleanup install
```shell
helm uninstall nestjs-metrics
```