BEGIN;
CREATE TABLE advisory (
 source text NOT NULL, external_id text NOT NULL, modified_at timestamptz NOT NULL,
 evidence jsonb NOT NULL, PRIMARY KEY (source,external_id)
);
CREATE TABLE affected_package (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 source text NOT NULL, external_id text NOT NULL, ecosystem text NOT NULL,
 package_name text NOT NULL, affected_range jsonb NOT NULL,
 FOREIGN KEY(source,external_id) REFERENCES advisory(source,external_id)
);
CREATE TABLE workload (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 cluster_id text NOT NULL, namespace text NOT NULL, pod_uid text NOT NULL,
 container_name text NOT NULL, image_digest text NOT NULL,
 UNIQUE(cluster_id,pod_uid,container_name,image_digest)
);
CREATE TABLE workload_package (
 workload_id bigint REFERENCES workload(id), purl text NOT NULL, version text NOT NULL,
 PRIMARY KEY(workload_id,purl,version)
);
CREATE TABLE runtime_event (
 source text NOT NULL, event_id text NOT NULL, observed_at timestamptz NOT NULL,
 workload_id bigint REFERENCES workload(id), event_type text NOT NULL, evidence jsonb NOT NULL,
 PRIMARY KEY(source,event_id)
);
CREATE TABLE finding (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 workload_id bigint NOT NULL REFERENCES workload(id),
 affected_package_id bigint NOT NULL REFERENCES affected_package(id),
 purl text NOT NULL, package_version text NOT NULL,
 match_status text NOT NULL CHECK(match_status IN ('affected','not_affected','unknown')),
 evidence jsonb NOT NULL, rule_version text NOT NULL,
 UNIQUE(workload_id,affected_package_id,purl,package_version,rule_version)
);
COMMIT;
