#!/usr/bin/env bash
# Read only; output may reveal infrastructure identifiers. Keep local.
set -u
command -v kubectl >/dev/null || exit 1
kubectl version
kubectl get --raw='/readyz?verbose'
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get ds -A
kubectl get storageclass
kubectl -n argocd get deploy,sts,svc
kubectl get applications.argoproj.io -A
