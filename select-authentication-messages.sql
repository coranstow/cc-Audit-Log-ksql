set 'auto.offset.reset'='earliest';
Create or replace stream confluent_audit_log_events_all_events_authentication
 with (kafka_topic='confluent-audit-log-events-authentication', value_format='avro', key_format='none')
 as select
    datacontenttype,
    EXTRACTJSONFIELD(data, '$.serviceName') as serviceName,
    EXTRACTJSONFIELD(data, '$.resourceName') as resourceName,
    EXTRACTJSONFIELD(data, '$.request') as request,
    EXTRACTJSONFIELD(data, '$.requestMetadata.connection_id') as connection_id,
    EXTRACTJSONFIELD(data, '$.result.status') as result_status,
    EXTRACTJSONFIELD(data, '$.result.message') as result_message,
    EXTRACTJSONFIELD(data, '$.methodName') as methodName,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.principal') as principal,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.principalResourceId') as principalResourceId,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.metadata.mechanism') as mechanism,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.metadata.identifier') as identifier,
    subject,
    specversion,
    id,
    source,
    time,
    type
 from confluent_audit_log_events_all_events where type='io.confluent.kafka.server/authentication' emit changes;