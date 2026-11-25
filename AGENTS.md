# Agent operating contract
- Read docs/master-prompt.md and docs/technical-spec.md before development.
- Work in feature branches and open PRs; small independently testable changes. Do not merge or deploy without owner approval.
- Existing CentOS/HAProxy/Docker/Calico/Argo CD and prod namespace are protected. Never reset nodes, change CNI, modify HAProxy, delete workloads or apply cluster-wide policies without explicit approval and tested rollback.
- Never commit credentials, kubeconfig, private addresses, real security events, or customer data. Use synthetic fixtures. No cloud resources or paid APIs.
- Python 3.11+ for backend; PostgreSQL migrations; React/TypeScript frontend. Use pinned dependencies and image digests before deployment. No invented chart versions or compatibility claims.
- Tests: python -m unittest discover -s tests -v; bash -n infra/preflight/*.sh (check each file individually). Add tests for every behavior change. Report commands actually run and limitations.
- CVE matching must use ecosystem and affected version ranges; unknown is not safe. Preserve source evidence and timestamps. Runtime evidence is not proof of exploitation.
- Start with observation and audit; enforcement is opt-in. Do not collect secrets, environment variables, or payloads by default.
