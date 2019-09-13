# Integrations

The Integrations API allows you to interact with integrations. Integrations are the sources of data monitored by Blue Matador.

## List Integrations

> List Integrations Example

```shell
curl https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/inbounds
```

> Example Response

```shell
[
  {
    "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
    "id": "d37da6af-1f87-4cd1-992f-113a60be9358",
    "inboundType": "aws",
    "created": "2019-03-22T15:07:08Z",
    "enabled": true,
    "data": {
      "name": "Prod AWS",
      "accountId": "50484629850", // AWS account ID
      "keyType": "aws",
      // non-sensitive key parts only
      "keys": {
        "accessKeyId": "AKIAU6EBUO39S2JQAB03"
      },
      "status": {
        "lastSuccess": "2019-03-23T09:01:01Z",
        "lastError": null,
        "recentErrors": []
      },
    }
  },
  ...
]
```

Lists all integrations for an account.

### HTTP Request

`GET https://api.bluematador.com/zi/accounts/<account_id>/inbounds`

## Create AWS Integration

> Create AWS Integration Example

```shell
curl -X POST  -H "Content-Type: application/json" \
  -d '{
    "name": "Prod AWS",
    "accessKeyId": "AKIAU6EBUO39S2JQAB03",
    "secretAccessKey": "Zx4xOm4ioTc0f3ylhGZkSSBp4P2M1KpcNlV2Uoe1"
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/inbounds/aws"
```

> Example Response

```shell
{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "d37da6af-1f87-4cd1-992f-113a60be9358",
  "inboundType": "aws",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "name": "Prod AWS",
    "accountId": "50484629850", // AWS account ID
    "keyType": "aws",
    // non-sensitive key parts only
    "keys": {
      "accessKeyId": "AKIAU6EBUO39S2JQAB03"
    },
    "status": {
      "lastSuccess": null,
      "lastError": null,
      "recentErrors": []
    },
  }
}
```

This endpoint creates a new AWS integration.

### HTTP Request

`POST https://api.bluematador.com/zi/accounts/<account_id>/inbounds/aws`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account to create an integration for

### Request Body

The AWS integration can authenticate with either IAM users or IAM roles, and the shape of your request payload determines which type of authentication will be used.

#### IAM User Authentication
Name | Type | Description
---- | ---- | -----------
name | string | a name used to identify the new integration
accessKeyId | string | the Access Key ID of the IAM user to authenticate as
secretAccessKey | string | the secret for the access key

#### IAM Role Assumption
Name | Type | Descirption
---- | ---- | -----------
name | string | a name used to identify the new integration
roleArn | string | the ARN for the IAM role to assume
externalId | string | a string used as the external ID when assuming the role

When using IAM Role authentication, the role must be set up to allow Blue Matador's AWS account as a trusted identity so that Blue Matador can use AssumeRole. Blue Matador's AWS Account ID is: 339597358577

## Update AWS Integration

> Update AWS Integration Example

```shell
curl -X PUT  -H "Content-Type: application/json" \
  -d '{
    "name": "Prod AWS",
    "accessKeyId": "AKIAU5EBCO39SDJQAB01",
    "secretAccessKey": "1x4xCm4ioTc0f3ylhGZtSSBp4P2M1npcNlV2Uoec"
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/inbounds/aws/d37da6af-1f87-4cd1-992f-113a60be9358"
```

> Example Response

```shell
{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "d37da6af-1f87-4cd1-992f-113a60be9358",
  "inboundType": "aws",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "name": "Prod AWS",
    "accountId": "10384429840", // AWS account ID
    "keyType": "aws",
    // non-sensitive key parts only
    "keys": {
      "accessKeyId": "AKIAU5EBCO39SDJQAB01"
    },
    "status": {
      "lastSuccess": "2019-03-23T09:01:01Z",
      "lastError": null,
      "recentErrors": []
    },
  }
}
```

This endpoint updates an existing AWS integration.

### HTTP Request

`PUT https://api.bluematador.com/zi/accounts/<account_id>/inbounds/aws/<id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account that owns the integration
id | UUID | the id of the integration to update

### Request Body

The AWS integration can authenticate with either IAM users or IAM roles, and the shape of your request payload determines which type of authentication will be used.

#### IAM User Authentication

If you are only updating the name of the integration, you can omit credentials.

Name | Type | Description
---- | ---- | -----------
name | string | a name used to identify the new integration
accessKeyId | string | (optional) the Access Key ID of the IAM user to authenticate as
secretAccessKey | string | (optional) the secret for the access key

#### IAM Role Assumption

If you are only updating the name of the integration, you can omit credentials.

Name | Type | Description
---- | ---- | -----------
name | string | a name used to identify the new integration
roleArn | string | (optional) the ARN for the IAM role to assume
externalId | string | (optional) a string used as the external ID when assuming the role

## Create Azure Integration

> Create Azure Integration Example

```shell
curl -X POST  -H "Content-Type: application/json" \
  -d '{
    "name": "Prod Azure Subscription",
    "subscriptionId": "c37da5a1-bf17-9cd0-092e-b13360be9355",
    "tenantId": "6678a6aa-cf84-6c11-d95f-517a60be0351",
    "applicationId": "16b8a699-468c-cc44-195d-a12a628e8352",
    "secret": "-5eF10S0Cu7[h?AAa4nscA?19?5c+2.Zs"
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/inbounds/azure"
```

> Example Response

```shell
{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "d37da6af-1f87-4cd1-992f-113a60be9358",
  "inboundType": "azure",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "name": "Prod Azure Subscription",
    "subscriptionId": "c37da5a1-bf17-9cd0-092e-b13360be9355",
    "tenantId": "6678a6aa-cf84-6c11-d95f-517a60be0351",
    // non-sensitive key parts only
    "keys": {
      "applicationId": "16b8a699-468c-cc44-195d-a12a628e8352"
    },
    "status": {
      "lastSuccess": null,
      "lastError": null,
      "recentErrors": []
    },
  }
}
```

This endpoint creates a new Azure integration. Authentication for the Azure is handled through app registrations in active directory.

### HTTP Request

`POST https://api.bluematador.com/zi/accounts/<account_id>/inbounds/azure`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account to create an integration for

### Request Body

Name | Type | Description
---- | ---- | -----------
name | string | a name used to identify the new integration
subscriptionId | uuid | the ID of the subscription to be monitored
tenantId | uuid | the ID of the active directory containing the Blue Matador app registration
applicationId | uuid | the ID of the app registration
secret | string | the client secret

## Update Azure Integration

> Update Azure Integration Example

```shell
curl -X PUT  -H "Content-Type: application/json" \
  -d '{
    "name": "Prod Azure Subscription",
    "subscriptionId": "c37da5a1-bf17-9cd0-092e-b13360be9355",
    "tenantId": "6678a6aa-cf84-6c11-d95f-517a60be0351",
    "applicationId": "16b8a699-468c-cc44-195d-a12a628e8352",
    "secret": "-5eF10S0Cu7[h?AAa4nscA?19?5c+2.Zs"
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/inbounds/azure/d37da6af-1f87-4cd1-992f-113a60be9358"
```

> Example Response

```shell
{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "d37da6af-1f87-4cd1-992f-113a60be9358",
  "inboundType": "azure",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "name": "Prod Azure Subscription",
    "subscriptionId": "c37da5a1-bf17-9cd0-092e-b13360be9355",
    "tenantId": "6678a6aa-cf84-6c11-d95f-517a60be0351",
    // non-sensitive key parts only
    "keys": {
      "applicationId": "16b8a699-468c-cc44-195d-a12a628e8352"
    },
    "status": {
      "lastSuccess": null,
      "lastError": null,
      "recentErrors": []
    },
  }
}
```

This endpoint updates an existing Azure integration.

### HTTP Request

`PUT https://api.bluematador.com/zi/accounts/<account_id>/inbounds/azure/<id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account that owns the integration
id | UUID | the id of the integration to update

### Request Body

Name | Type | Description
---- | ---- | -----------
name | string | a name used to identify the new integration
subscriptionId | uuid | (optional) the ID of the subscription to be monitored
tenantId | uuid | (optional) the ID of the active directory containing the Blue Matador app registration
applicationId | uuid | (optional) the ID of the app registration
secret | string | (optional) the client secret

## Disable an Integration

> Disable Integration Example

```shell
curl -X PUT "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/inbounds/d37da6af-1f87-4cd1-992f-113a60be9358/disable"
```

> The endpoint returns 200 OK when successful

This endpoint allows you to disable an integration. Disabled integrations are not monitored by Blue Matador.

### HTTP Request

`PUT https://api.bluematador.com/zi/accounts/<account_id>/inbounds/<id>/disable`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account that owns the integration
id | UUID | the id of the integration to disable

## Enable an Integration

> Enable Integration Example

```shell
curl -X PUT "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/inbounds/d37da6af-1f87-4cd1-992f-113a60be9358/disable"
```

> The endpoint returns 200 OK when successful

This endpoint allows you to re-enable an integration.

### HTTP Request

`PUT https://api.bluematador.com/zi/accounts/<account_id>/inbounds/<id>/enable`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account that owns the integration
id | UUID | the id of the integration to enable

## Delete an Integration

> Delete Integration Example

```shell
curl -X DELETE "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/inbounds/d37da6af-1f87-4cd1-992f-113a60be9358"
```

> The endpoint returns 200 OK when successful

This endpoint allows you to delete an integration.

<aside class="notice">An integration must be disabled before it can be deleted.</aside>

<aside class="warning">This action is permanent. Deleted integrations cannot be recovered.</aside>

### HTTP Request

`DELETE https://api.bluematador.com/zi/accounts/<account_id>/inbounds/<id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account that owns the integration
id | UUID | the id of the integration to delete
