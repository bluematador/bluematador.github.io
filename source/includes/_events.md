# Events

The Events API allows you to retrieve event related data from Blue Matador.

## Get Events

> Example Request

```shell
curl "https://app.bluematador.com/ma/api/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/events?start=2019-03-22T00:00:00Z&end=2019-03-23T00:00:00Z"
```

> Example Response

```shell
[
  {
    // id of the event
    "id": "b97da6af-1f87-4cd1-992f-113a60be9358",
    // id of the account
    "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
    // event opened date
    "opened": "2019-03-22T15:07:08Z",
    // event close date (optional)
    “closed”: null,
    // enum of the type of event
    "eventType": "route53_zone_ns",
    // display string for type of event
    "typeText": "Route53 Zone NS Records",
    // display string for event summary
    "summaryText": "The configured NS records for the zone does not match the actual query response",
    // list of additional details about the event
    "detailTexts": [
      "ns-1408.awsdns-60.org.",
      "ns-1781.awsdns-18.co.uk.",
      "ns-31.awsdns-04.com.",
      "ns-792.awsdns-26.net."
    ],
    // anomaly, warning, alert
    "severity": "anomaly",
    // details about the resource affected by the event
    "source": {
      // identification data about the resource
      "ref": {
        "arn": "arn:aws:route53:::hostedzone/Z132S03H3a5QD",
        "refType": "aws_arn"
      }",
      // a label describing the type of resource
      "label": "Route53 Zone",
      // a text representation of the resource
      "text": "thedevcloud.com.",
      // a list of key-value pairs that further identify the resource
      "tags": [
        {
          "key": "AWS Account",
          "value": "blue-poc"
        },
        {
          "key": "Public",
          "value": "true"
        },
        {
          "key": "Zone ID",
          "value": "Z132S03H3a5QD"
        }
      ]
    },
    // links to event troubleshooting, AWS, and incident management
    "links": [
      {
        "linkType": "troubleshooting",
        "text": "Troubleshooting",
        "url": "https://app.bluematador.com/ur/troubleshooting/route53-hosted-zone#ns",
        "created": "2019-03-22T17:11:08.092Z"
      },
      {
        "linkType": "aws",
        "text": "AWS Console",
        "url": "https://app.bluematador.com/ur/awsLink?url=https%3A%2F%2Fconsole.aws.amazon.com%2Froute53%2Fhome%23resource-record-sets%3AZ152S03H3I5QD",
        "created": "2019-03-22T17:11:08.092Z"
      }
    ],
    // a list of projects the event belongs to
    "projects": [
      {
        "id": "6f0ac475-4594-4b86-87d7-7f8b0645126a",
        "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
        "created": "2019-02-19T17:41:05Z",
        "name": "Sandbox"
      }
    ],
    // whether the event was not sent to notification systems
    "muted": false,
    // whether the event should be hidden
    "hidden": false
  },
…
]
```

This endpoint retrieves Blue Matador events from an account within a time period

### HTTP Request

`GET https://app.bluematador.com/ma/api/accounts/<account_id>/events`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account to get events from

### Query Parameters

Name | Type | Description
---- | ---- | -----------
start | ISO 8601 date | the open time for the earliest events to retrieve
end | ISO 8601 date | the open time for the latest events to retrieve
project | string | (optional) only get events for a particular project

## Graphs

> Example Request

```shell
curl "https://app.bluematador.com/ma/api/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351/counts"
```

> Example Response

```shell
{
  // an object containing anomaly, warning, alert objects containing
  // the number of events in that severity opened that day
  "opened": {
    "warning": {
      "2019-03-01T00:00:00Z": 35,
      "2019-03-13T00:00:00Z": 43,
      "2019-03-06T00:00:00Z": 28,
      ...
    },
    "anomaly": {
      "2019-03-01T00:00:00Z": 52,
      "2019-03-13T00:00:00Z": 45,
      "2019-03-06T00:00:00Z": 33,
      ...
    },
    "alert": {
      "2019-03-01T00:00:00Z": 0,
      "2019-03-13T00:00:00Z": 1,
      "2019-03-06T00:00:00Z": 0,
      ...
    }
  },
  // an object containing anomaly, warning, alert objects containing
  // the number of events in that severity active that day
  "active": {
    "warning": {
      "2019-03-01T00:00:00Z": 45,
      "2019-03-13T00:00:00Z": 51,
      "2019-03-06T00:00:00Z": 35,
      ...
    },
    "anomaly": {
      "2019-03-01T00:00:00Z": 59,
      "2019-03-13T00:00:00Z": 52,
      "2019-03-06T00:00:00Z": 41,
      ...
    },
    "alert": {
      "2019-03-01T00:00:00Z": 12,
      "2019-03-13T00:00:00Z": 13,
      "2019-03-06T00:00:00Z": 12,
      ...
    }
  }
}

```

The Graphs API endpoint returns the counts of events opened and active for each day in the last 30 days for an account.

### HTTP Request

`GET https://app.bluematador.com/ma/api/accounts/<account_id>/counts`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
account_id | UUID | the ID of the account to get counts from

### Query Parameters

Name | Type | Description
---- | ---- | -----------
project | string | (optional) only get counts for a particular project
