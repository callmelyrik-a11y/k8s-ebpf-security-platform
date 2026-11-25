# Local bootstrap
1. Run cluster.sh on an authorized control-plane shell and node.sh on each node. Keep results private.
2. Confirm server version, distribution, actual runtime endpoint, kernel/BTF, CNI and storage. Kubernetes 1.27 is EOL; choose supported upgrade and chart matrix before installation.
3. Back up etcd and configuration using the existing distribution's procedure and verify recovery. Do not use kubeadm commands until distribution is confirmed.
4. Review gitops/bootstrap/application.yaml. It deploys only the initial namespace and configuration marker, not any agents or workload. Existing Argo CD must have access to the repo and destination. Apply manually after reviewing rendered YAML: kubectl kustomize gitops/environments/local; kubectl apply -f gitops/bootstrap/application.yaml; then use Argo CD UI to inspect and manually sync. Automated sync and prune are disabled.
5. For rollback remove the Application without cascading deletion; review each namespaced resource separately. Do not delete the namespace if it contains data.
6. Do not change HAProxy, install a second CNI or expose the API externally. Cilium migration requires separate version-specific plan and maintenance window.
