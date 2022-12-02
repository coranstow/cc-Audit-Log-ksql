#KSQL for Confluent Audit
This repo contains some ksql statements that manage Confluent Clout audit logs. It assumes that the confluent audit log topic has beeen mirrored into the local cluster by Confluent Cluster Linking.

## Start by creating a stream over the mirror topic and replicating everything into a new topic.
The mirror topic has a restrictions on what we can do with it, including a restriction on changing the retention time away. We will replicate the mesages from the mirror topic into a new topic with different settings, including a longer retention.

`create-retrained-audit-stream-topic.sql` will 
1. Create the stream `confluent_audit_log_events_mirror_raw` over the audit mirror topic
2. Create the stream `confluent_audit_log_events_mirror_retained`, the topic `confluent-audit-log-events-retained`, and a persistent query that will copy the raw messages from the mirror topic to `confluent-audit-log-events-retained` without deserializing.
3. Create the stream `confluent_audit_log_events_all_events` that contains all the audit events from `confluent-audit-log-events-retained` deserialized as JSON.

Note that the `data` field of the `confluent_audit_log_events_all_events` stream is dynamically typed. That is the schema of the JSON in the `data` field will depend on the falue of the `type` field. There are three possible schemas corresponding to the three types of events that are audited - authentication, authorization, request. 

