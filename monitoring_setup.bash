#!/bin/bash

kubectl create namespace monitoring

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

kubectl apply -f prometheus-storage.yaml -f prometheus-pv.yaml -n monitoring
helm install prometheus prometheus-community/prometheus --version 25.17.0 --namespace monitoring -f prometheus-values.yaml

kubectl apply -f grafana-storage.yaml -f grafana-pv.yaml -n monitoring
helm install grafana grafana/grafana -n monitoring -f grafana-values.yaml --version 7.3.7