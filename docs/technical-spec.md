# Technical specification
## Boundaries
Existing Kubernetes, HAProxy and Argo CD are external dependencies. Calico remains active until a supported migration is approved. No AWS, no new VM, no automatic pruning, no privileged CI runners.
## Data flow
Collectors ingest public advisories from NVD, OSV and CISA KEV with rate limiting and retry. SBOM ingestion supports CycloneDX and normalizes package URLs (purl). Runtime event adapters normalize Tetragon and Hubble JSON; discard secrets and payloads. PostgreSQL stores advisory evidence, affected ranges, workloads, packages, findings and events.
## Contracts
CVE: source, external_id, modified_at, ecosystem, package, affected_range, severity, KEV status. Keep source-specific evidence, not only merged CVE rows.
Workload identity: cluster_id, namespace, pod_uid, container, image_digest. Never match exclusively by mutable tag.
Event: source, event_id, observed_at, workload identity, event_type, minimal evidence. Duplicate keys are idempotent; retain UTC timestamps.
Finding: advisory + workload + package + match status (affected/not_affected/unknown), evidence and scoring rule version. No automatic claim of exploitation.
## API plan
GET /healthz, /v1/findings, /v1/events, /v1/workloads with pagination; authenticated access before exposing data. Dashboard displays confidence and evidence.
## Acceptance
Offline fixture tests; repeat ingestion without duplication; unknown versions remain unknown; no secret data in logs; documented rollback; all dependencies and manifests reviewed and pinned. Initial CI only runs offline tests and shell syntax checks.
