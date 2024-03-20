#!/bin/bash

helm uninstall prometheus -n monitoring
helm uninstall grafana -n monitoring
kubectl delete -f prometheus-storage.yaml -f prometheus-pv.yaml -n monitoring
kubectl delete -f grafana-storage.yaml -f grafana-pv.yaml -n monitoring

kubectl delete namespace monitoring