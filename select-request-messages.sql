set 'auto.offset.reset'='earliest';
Create or replace stream confluent_audit_log_events_all_events_request
with (kafka_topic='confluent-audit-log-events-request', value_format='avro', key_format='none')
as select
    datacontenttype,
    EXTRACTJSONFIELD(data, '$.serviceName') as serviceName,
    EXTRACTJSONFIELD(data, '$.methodName') as methodName,
    EXTRACTJSONFIELD(data, '$.cloudResources.scope.resources') as cloudResources_scope_resources,
    EXTRACTJSONFIELD(data, '$.cloudResources.resource') as cloudResources_resource,
    EXTRACTJSONFIELD(data, '$.resourceName') as resourceName,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.principal.email') as authentication_principal_email,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.principal.confluentUser.resourceId') as authentication_principal_confluentUser,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.principal.confluentServiceAccount.resourceId') as authentication_principal_confluentServiceAccount,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.principal.externalAccount.namespace.type') as authentication_principal_externalAccount_namespace_type,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.principal.externalAccount.namespace.id') as authentication_principal_externalAccount_namespace_id,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.principal.externalAccount.subject') as authentication_principal_externalAccount_subject,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.originalPrincipal.email') as authentication_originalPrincipal_email,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.originalPrincipal.confluentUser.resourceId') as authentication_originalPrincipal_confluentUser,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.originalPrincipal.confluentServiceAccount.resourceId') as authentication_originalPrincipal_confluentServiceAccount,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.originalPrincipal.externalAccount.namespace.type') as authentication_originalPrincipal_externalAccount_namespace_type,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.originalPrincipal.externalAccount.namespace.id') as authentication_originalPrincipal_externalAccount_namespace_id,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.originalPrincipal.externalAccount.subject') as authentication_originalPrincipal_externalAccount_subject,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.result') as authentication_result,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.errorMessage') as authentication_errorMessage,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.credentials.idSecretCredentials.credentialId') as authentication_credentials_idSecretCredentials_credentialId,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.credentials.idTokenCredentials.type') as authentication_credentials_idTokenCredentials_type,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.credentials.idTokenCredentials.issuer') as authentication_credentials_idTokenCredentials_issuer,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.credentials.idTokenCredentials.subject') as authentication_credentials_idTokenCredentials_subject,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.credentials.idTokenCredentials.audience') as authentication_credentials_idTokenCredentials_audience,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.credentials.certificateCredentials.dname') as authentication_credentials_certificateCredentials_dname,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.credentials.delegateCredentials.delegatePrincipal.email') as authentication_credentials_certificateCredentials_delegatePrincipal_email,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.credentials.delegateCredentials.delegatePrincipal.confluentUser.resourceId') as authentication_credentials_certificateCredentials_delegatePrincipal_confluentUser,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.credentials.delegateCredentials.delegatePrincipal.confluentServiceAccount.resourceId') as authentication_credentials_certificateCredentials_delegatePrincipal_confluentServiceAccount,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.credentials.delegateCredentials.delegatePrincipal.externalAccount.namespace') as authentication_credentials_certificateCredentials_delegatePrincipal_externalAccount_namespace,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.credentials.delegateCredentials.delegatePrincipal.externalAccount.subject') as authentication_credentials_certificateCredentials_delegatePrincipal_externalAccount_subject,
    EXTRACTJSONFIELD(data, '$.authenticationInfo.credentials.mechanism') as authentication_credentials_mechanism,
    EXTRACTJSONFIELD(data, '$.authorizationInfo.result') as authorization_result,
    EXTRACTJSONFIELD(data, '$.authorizationInfo.operation') as authorization_operation,
    EXTRACTJSONFIELD(data, '$.requestMetadata') as requestMetadata,
    EXTRACTJSONFIELD(data, '$.request') as request,
     EXTRACTJSONFIELD(data, '$.result') as result,

    subject,
    specversion,
    id,
    source,
    time,
    type
 from confluent_audit_log_events_all_events where type='io.confluent.kafka.server/request' emit changes;