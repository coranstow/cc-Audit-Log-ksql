Create or replace stream confluent_audit_log_events_mirror_raw (data VARCHAR)
with (kafka_topic='confluent-audit-log-events', key_format='none', value_format='kafka');

CREATE OR REPLACE STREAM confluent_audit_log_events_mirror_retained
with (kafka_topic='confluent-audit-log-events-retained', partitions='12', key_format='none', value_format='kafka')
as select * from confluent_audit_log_events_mirror_raw emit changes;

Create or replace stream confluent_audit_log_events_all_events (
    datacontenttype VARCHAR,
    data VARCHAR,
    subject VARCHAR,
    specversion VARCHAR,
    id VARCHAR,
    source VARCHAR,
    time VARCHAR,
    type VARCHAR
)
with (kafka_topic='confluent-audit-log-events-retained', value_format='json', key_format='none');