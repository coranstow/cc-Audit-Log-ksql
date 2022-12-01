set 'auto.offset.reset'='earliest';
Create or replace stream confluent_audit_log_events_all_events_authorization
 with (kafka_topic='confluent-audit-log-events-authorization', value_format='avro', key_format='none')
 as select
    datacontenttype,
    EXTRACTJSONFIELD(data, '$.serviceName') as serviceName,
    EXTRACTJSONFIELD(data, '$.resourceName') as resourceName,
    EXTRACTJSONFIELD(data, '$.methodName') as methodName,
    EXTRACTJSONFIELD(data, '$.request.clientId') as request_clientId,
    EXTRACTJSONFIELD(data, '$.request.correlationId') as request_correlationId,
    EXTRACTJSONFIELD(data, '$.requestMetadata.request_id') as requestMetadata_requestId,
    EXTRACTJSONFIELD(data, '$.requestMetadata.connection_id') as requestMetadata_connectionId,
    EXTRACTJSONFIELD(data, '$.result.status') as result_status,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.principal') as authentication_principal,
    EXTRACTJSONFIELD(data, '$.authorizationInfo.granted') as authorization_granted,
    EXTRACTJSONFIELD(data, '$.authorizationInfo.operation') as authorization_operation,
    EXTRACTJSONFIELD(data, '$.authorizationInfo.resourceType') as authorization_resourceType,
    EXTRACTJSONFIELD(data, '$.authorizationInfo.resourceName') as authorization_resourceName,
    EXTRACTJSONFIELD(data, '$.authorizationInfo.patternType') as authorization_patternType,
    EXTRACTJSONFIELD(data, '$.authorizationInfo.aclAuthorization.permissionType') as authorization_permissionType,
    EXTRACTJSONFIELD(data, '$.authorizationInfo.aclAuthorization.host') as authorization_host,
    EXTRACTJSONFIELD(data, '$.authorizationInfo.rbacAuthorization.role') as authorization_rbac_role,
    EXTRACTJSONFIELD(data, '$.authorizationInfo.rbacAuthorization.scope.outerScope') as authorization_rbac_outerScope,
    EXTRACTJSONFIELD(data, '$.authorizationInfo.superUserAuthorization') as authorization_superUserAuthorization,
    subject,
    specversion,
    id,
    source,
    time,
    type
 from confluent_audit_log_events_all_events where type='io.confluent.kafka.server/authorization' emit changes;