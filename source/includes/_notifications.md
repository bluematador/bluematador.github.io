# Notifications

The Notifications API allows you to interact with notification methods. Events detected by Blue Matador are sent through these notification methods.

## List Notifications

> List Notification Example

```shell
curl https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds
```

> Example Response

```shell
[
  {
    "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
    "id": "086e5a82-3116-4257-8f6b-260ec3fef2cd",
    "created": "2019-03-22T15:07:08Z",
    "enabled": true,
    "data": {
      "status": {
        "lastSuccess": "2019-03-23T09:01:01Z",
        "lastError": null,
        "recentErrors": []
      },
      "severities": {
        "all": [
          "warning",
          "alert"
        ],
        "3833aa2a-de1c-4b48-8722-4ec79fb6c2e4": [
          "warning"
        ]
      },
      "email": "example@example.com"
    },
    "credentials": null,
    "outboundType": "email"
  },
  ...
]
```

Lists all notifications for an account. Notification objects differ based on their type.

### HTTP Request

`GET https://api.bluematador.com/zi/accounts/<account_id>/outbounds`

## Create an Email Notification

> Create Email Notification Example

```shell
curl -X POST -H "Content-Type: application/json" \
  -d '{
    "email": "example@example.com",
    "severities": {
      "all": ["alert", "warning"],
    }
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds/email"
```

> Example Response

```shell
{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "686e5a82-3116-4257-8f6b-260ec3fef2cd",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "status": {
      "lastSuccess": null,
      "lastError": null,
      "recentErrors": []
    },
    "severities": {
      "all": [
        "warning",
        "alert"
      ],
    },
    "email": "example@example.com"
  },
  "credentials": null,
  "outboundType": "email"
}
```

This endpoint creates a new email notification.

### HTTP Request

`POST https://api.bluematador.com/zi/accounts/<account_id>/outbounds/email`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account to create a notification for

### Request Body

Name | Type | Description
---- | ---- | -----------
email | string | the email address to send notifications to
severities | Object | a map of [project](https://www.bluematador.com/docs/project-setup) to an array of the event types to notify on ([read more](#severities))

## Update an Email Notification

> Update Email Notification Example

```shell
curl -X PUT -H "Content-Type: application/json" \
  -d '{
    "email": "example@example.com",
    "severities": {
      "all": ["alert", "warning"],
    }
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds/email/686e5a82-3116-4257-8f6b-260ec3fef2cd"
```

> Example Response

```shell
{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "686e5a82-3116-4257-8f6b-260ec3fef2cd",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "status": {
      "lastSuccess": "2019-03-23T09:01:01Z",
      "lastError": null,
      "recentErrors": []
    },
    "severities": {
      "all": [
        "warning",
        "alert"
      ],
    },
    "email": "example@example.com"
  },
  "credentials": null,
  "outboundType": "email"
}
```

This endpoint updates an existing email notification.

### HTTP Request

`PUT https://api.bluematador.com/zi/accounts/<account_id>/outbounds/email/<id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account that owns the notification
id | UUID | the ID of the notification to update

### Request Body

Name | Type | Description
---- | ---- | -----------
email | string | the email address to send notifications to
severities | Object | a map of [project](https://www.bluematador.com/docs/project-setup) to an array of the event types to notify on ([read more](#severities))

## Create a PagerDuty Notification

> Create PagerDuty Notification Example

```shell
curl -X POST -H "Content-Type: application/json" \
  -d '{
    "name": "Prod PagerDuty",
    "severities": {
      "all": ["alert", "warning"],
    },
    "account": "example-pagerduty",
    "serviceName": "example Blue Matador",
    "serviceKey": "445cce5a3ad04113b4eb810c1b8cfd03"
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds/pagerduty"
```

> Example Response

```shell
{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "686e5a82-3116-4257-8f6b-260ec3fef2cd",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "name": "Prod Pagerduty",
    "status": {
      "lastSuccess": null,
      "lastError": null,
      "recentErrors": []
    },
    "severities": {
      "all": [
        "warning",
        "alert"
      ],
    },
    "account": "example-pagerduty",
    "serviceName": "example Blue Matador"
  },
  "credentials": "<secret>",
  "outboundType": "pagerduty"
}
```

This endpoint creates a new PagerDuty notification.

### HTTP Request

`POST https://api.bluematador.com/zi/accounts/<account_id>/outbounds/pagerduty`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account to create a notification for

### Request Body

Name | Type | Description
---- | ---- | -----------
name | string | a name used to identify the new notification
severities | Object | a map of [project](https://www.bluematador.com/docs/project-setup) to an array of the event types to notify on ([read more](#severities))
account | string | the name of the PagerDuty account to notify
serviceName | string | the name of the PagerDuty service to notify
serviceSecret | string | the API key for the service

## Update a PagerDuty Notification

> Update PagerDuty Notification Example

```shell
curl -X PUT -H "Content-Type: application/json" \
  -d '{
    "name": "Prod PagerDuty",
    "severities": {
      "all": ["alert", "warning"],
    },
    "account": "example-pagerduty",
    "serviceName": "example Blue Matador"
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds/pagerduty/686e5a82-3116-4257-8f6b-260ec3fef2cd"
```

> Example Response

```shell
{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "686e5a82-3116-4257-8f6b-260ec3fef2cd",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "name": "Prod Pagerduty",
    "status": {
      "lastSuccess": "2019-03-23T09:01:01Z",
      "lastError": null,
      "recentErrors": []
    },
    "severities": {
      "all": [
        "warning",
        "alert"
      ],
    },
    "account": "example-pagerduty",
    "serviceName": "example Blue Matador"
  },
  "credentials": "<secret>",
  "outboundType": "pagerduty"
}
```

This endpoint updates an existing PagerDuty notification.

### HTTP Request

`PUT https://api.bluematador.com/zi/accounts/<account_id>/outbounds/pagerduty/<id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account that owns the notification
id | UUID | the ID of the notification to update

### Request Body

Name | Type | Description
---- | ---- | -----------
name | string | a name used to identify the notification
severities | Object | a map of [project](https://www.bluematador.com/docs/project-setup) to an array of the event types to notify on ([read more](#severities))
account | string | the name of the PagerDuty account to notify
serviceName | string | the name of the PagerDuty service to notify
serviceSecret | string | (optional) the API key for the service

## Create an Opsgenie Notification

> Create Opsgenie Notification Example

```shell
curl -X POST -H "Content-Type: application/json" \
  -d '{
    "name": "Prod Opsgenie",
    "severities": {
      "all": ["alert", "warning"],
    },
    apikey: "a9e34f4c-c341-1546-b5ea-af1a33aeacf7"
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds/opsgenie"
```

> Example Response

```shell
{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "686e5a82-3116-4257-8f6b-260ec3fef2cd",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "name": "OpsGenie Prod",
    "status": {
      "lastSuccess": null,
      "lastError": null,
      "recentErrors": []
    },
    "severities": {
      "all": []
    }
  },
  "credentials": "<secret>",
  "outboundType": "opsgenie"
}
```

This endpoint creates a new Opsgenie notification.

### HTTP Request

`POST https://api.bluematador.com/zi/accounts/<account_id>/outbounds/opsgenie`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account to create a notification for

### Request Body

Name | Type | Description
---- | ---- | -----------
name | string | a name used to identify the new notification
severities | Object | a map of [project](https://www.bluematador.com/docs/project-setup) to an array of the event types to notify on ([read more](#severities))
apikey | string | the apikey from the Opsgenie integration to use

## Update an Opsgenie Notification

> Update Opsgenie Notification Example

```shell
curl -X PUT -H "Content-Type: application/json" \
  -d '{
    "name": "Prod Opsgenie",
    "severities": {
      "all": ["alert", "warning"],
    }
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds/opsgenie/686e5a82-3116-4257-8f6b-260ec3fef2cd"
```

> Example Response

```shell
{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "686e5a82-3116-4257-8f6b-260ec3fef2cd",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "name": "OpsGenie Prod",
    "status": {
      "lastSuccess": "2019-03-23T09:01:01Z",
      "lastError": null,
      "recentErrors": []
    },
    "severities": {
      "all": []
    }
  },
  "credentials": "<secret>",
  "outboundType": "opsgenie"
}
```

This endpoint updates an existing Opsgenie notification.

### HTTP Request

`PUT https://api.bluematador.com/zi/accounts/<account_id>/outbounds/opsgenie/<id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account that owns the notification
id | UUID | the ID of the notification to update

### Request Body

Name | Type | Description
---- | ---- | -----------
name | string | a name used to identify the notification
severities | Object | a map of [project](https://www.bluematador.com/docs/project-setup) to an array of the event types to notify on ([read more](#severities))
apikey | string | (optional) the apikey from the Opsgenie integration to use

## Create an SNS Notification

> Create SNS Notification Example

```shell
curl -X POST -H "Content-Type: application/json" \
  -d '{
    "name": "Prod SNS",
    "severities": {
      "all": ["alert", "warning"],
    },
    "topicArn": "arn:aws:sns:us-east-1:536714378879:oncall",
    "accessKeyId": "AKIAU6EBUO39S2JQAB03",
    "secretAccessKey": "Zx4xOm4ioTc0f3ylhGZkSSBp4P2M1KpcNlV2Uoe1"
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds/sns"
```

> Example Response

```shell
{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "686e5a82-3116-4257-8f6b-260ec3fef2cd",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "name": "Prod SNS",
    "status": {
      "lastSuccess": null,
      "lastError": null,
      "recentErrors": []
    },
    "severities": {
      "all": [
        "alert",
        "warning"
      ]
    },
    "topicArn": "arn:aws:sns:us-east-1:536714378879:oncall",
    "accessKeyId": "AKIAU6EBUO39S2JQAB03"
  },
  "credentials": "<secret>",
  "outboundType": "sns"
}
```

This endpoint creates a new SNS notification.

### HTTP Request

`POST https://api.bluematador.com/zi/accounts/<account_id>/outbounds/sns`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account to create a notification for

### Request Body

Name | Type | Description
---- | ---- | -----------
name | string | a name used to identify the new notification
severities | Object | a map of [project](https://www.bluematador.com/docs/project-setup) to an array of the event types to notify on ([read more](#severities))
topicArn | string | the ARN of the SNS topic to send notifications to
accessKeyId | string | the Access Key ID of the IAM user to authenticate as
secretAccessKey | string | the secret for the access key

## Update an SNS Notification

> Update SNS Notification Example

```shell
curl -X PUT -H "Content-Type: application/json" \
  -d '{
    "name": "Prod SNS",
    "severities": {
      "all": ["alert", "warning"],
    },
    "topicArn": "arn:aws:sns:us-east-1:536714378879:oncall",
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds/sns/686e5a82-3116-4257-8f6b-260ec3fef2cd"
```

> Example Response

```shell
{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "686e5a82-3116-4257-8f6b-260ec3fef2cd",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "name": "Prod SNS",
    "status": {
      "lastSuccess": "2019-03-23T09:01:01Z",
      "lastError": null,
      "recentErrors": []
    },
    "severities": {
      "all": [
        "alert",
        "warning"
      ]
    },
    "topicArn": "arn:aws:sns:us-east-1:536714378879:oncall",
    "accessKeyId": "AKIAU6EBUO39S2JQAB03"
  },
  "credentials": "<secret>",
  "outboundType": "sns"
}
```

This endpoint updates an existing SNS notification.

### HTTP Request

`PUT https://api.bluematador.com/zi/accounts/<account_id>/outbounds/sns/<id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account that owns the notification
id | UUID | the ID of the notification to update

### Request Body

Name | Type | Description
---- | ---- | -----------
name | string | a name used to identify the notification
severities | Object | a map of [project](https://www.bluematador.com/docs/project-setup) to an array of the event types to notify on ([read more](#severities))
topicArn | string | the ARN of the SNS topic to send notifications to
accessKeyId | string | (optional) the Access Key ID of the IAM user to authenticate as
secretAccessKey | string | (optional) the secret for the access key

## Create a VictorOps Notification

> Create VictorOps Notification Example

```shell
curl -X POST -H "Content-Type: application/json" \
  -d '{
    "name": "Prod VictorOps",
    "severities": {
      "all": ["alert", "warning"],
    },
    "integrationId": "29a7c0dd-8487-4248-9193-419fc43f03f8",
    "routingKey": "ops",
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds/victorops"
```

> Example Response

```shell

{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "686e5a82-3116-4257-8f6b-260ec3fef2cd",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "name": "Prod VictorOps",
    "status": {
      "lastSuccess": null,
      "lastError": null,
      "recentErrors": []
    },
    "severities": {
      "all": [
        "alert",
        "warning"
      ]
    }
  },
  "credentials": "<secret>",
  "outboundType": "victorops"
}
```

This endpoint creates a new VictorOps notification.

### HTTP Request

`POST https://api.bluematador.com/zi/accounts/<account_id>/outbounds/victorops`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account to create a notification for

### Request Body

Name | Type | Description
---- | ---- | -----------
name | string | a name used to identify the new notification
severities | Object | a map of [project](https://www.bluematador.com/docs/project-setup) to an array of the event types to notify on ([read more](#severities))
integrationId | string | the ID of the VictorOps integration to send notifications to
routingKey | string | the routing key VictorOps should use

## Update a VictorOps Notification

> Update VictorOps Notification Example

```shell
curl -X PUT -H "Content-Type: application/json" \
  -d '{
    "name": "Prod VictorOps",
    "severities": {
      "all": ["alert", "warning"],
    },
  }' \
  "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds/victorops/686e5a82-3116-4257-8f6b-260ec3fef2cd"
```

> Example Response

```shell

{
  "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
  "id": "686e5a82-3116-4257-8f6b-260ec3fef2cd",
  "created": "2019-03-22T15:07:08Z",
  "enabled": true,
  "data": {
    "name": "Prod VictorOps",
    "status": {
      "lastSuccess": "2019-03-23T09:01:01Z",
      "lastError": null,
      "recentErrors": []
    },
    "severities": {
      "all": [
        "alert",
        "warning"
      ]
    }
  },
  "credentials": "<secret>",
  "outboundType": "victorops"
}
```

This endpoint updates an existing VictorOps notification.

### HTTP Request

`PUT https://api.bluematador.com/zi/accounts/<account_id>/outbounds/victorops/<id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account that owns the notification
id | UUID | the ID of the notification to update

### Request Body

Name | Type | Description
---- | ---- | -----------
name | string | a name used to identify the notification
severities | Object | a map of [project](https://www.bluematador.com/docs/project-setup) to an array of the event types to notify on ([read more](#severities))
integrationId | string | (optional) the ID of the VictorOps integration to send notifications to
routingKey | string | (optional) the routing key VictorOps should use

## Severities

The severities map used when creating notifications allows you to control what types of events are sent to your notification methods. Blue Matador defines three levels of severity, Alert, Warning, and Anomaly. If you have [set up projects](https://www.bluematador.com/docs/project-setup), you can choose which severities you want on a project basis by providing the ID of your project mapped to the severities you'd like sent. For example, the following JSON:

```shell
{
  "all": ["alert"],
  "f651a7c4-9d49-4f23-8495-56d8a1d5e97c": ["alert", "warning", "anomaly"]
}
```

Would result in all events from resources belonging to the project with the ID `f651a7c4-9d49-4f23-8495-56d8a1d5e97c` being sent to your notification method. All alerts would also be sent to the notification.

If you haven't set up projects, your object will only have the `all` key.

## Disable a Notification

> Disable Notification Example

```shell
curl -X PUT "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds/086e5a82-3116-4257-8f6b-260ec3fef2cd/disable"
```

> The endpoint returns 200 OK when successful

This endpoint allows you to disable a notification. Disabled notifications will not be used by Blue Matador.

### HTTP Request

`PUT https://api.bluematador.com/zi/accounts/<account_id>/outbounds/<id>/disable`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account that owns the notification
id | UUID | the id of the notification to disable

## Enable a Notification

> Enable Notification Example

```shell
curl -X PUT "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds/086e5a82-3116-4257-8f6b-260ec3fef2cd/disable"
```

> The endpoint returns 200 OK when successful

This endpoint allows you to re-enable a notification.

### HTTP Request

`PUT https://api.bluematador.com/zi/accounts/<account_id>/outbounds/<id>/enable`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account that owns the notification
id | UUID | the id of the notification to enable

## Delete a Notification

> Delete Notification Example

```shell
curl -X DELETE "https://api.bluematador.com/zi/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/outbounds/086e5a82-3116-4257-8f6b-260ec3fef2cd"
```

> The endpoint returns 200 OK when successful

This endpoint allows you to delete a notification.

<aside class="notice">A notification must be disabled before it can be deleted.</aside>

<aside class="warning">This action is permanent. Deleted notifications cannot be recovered.</aside>

### HTTP Request

`DELETE https://api.bluematador.com/zi/accounts/<account_id>/outbounds/<id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account that owns the notification
id | UUID | the id of the notification to delete
