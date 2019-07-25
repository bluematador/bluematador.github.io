# Organizations

Organizations are a way of managing multiple Blue Matador accounts which each have their own integrations, notification methods, and events. When organizations is enabled, user permissions are managed for all accounts in the organization with a shared set of users.

<aside class="warning">This feature can only be enabled by your account manager.</aside>





## Authentication

> An example of authenticating with Blue Matador

```shell
curl "organization_api_endpoint_here"
  -H "Authorization: rha7sn5brxab4kh6a7hbe62q3jq1dpee7khpabcd"
```

> Make sure to replace `rha7sn5brxab4kh6a7hbe62q3jq1dpee7khpabcd` with your organization key

All organization endpoints are authenticated using an Organization Key instead of an account API key. Simply pass the organization key in the Authorization header as shown:





## List Accounts

> List Accounts Example

```shell
curl https://api.bluematador.com/zi/organization/40b59978-7e87-4129-aceb-cf9a98c36c62/accounts
```

> Example Response: 200 OK

```json-doc
[
  {
    // The ID of this account
    "id": "a976a6af-cf87-4dd1-942f-b13a30be9351",
    "created": "2019-01-01T00:00:00Z",
    "data": {
      "stripeId": null,
      // The name given to this account
      "company": "Subsidiary 1",
      "disabled": false,
      "paid": false,
      "trialEnd": "2019-01-15T00:00:00Z",
      "assessment": null,
      "trialWalled": false,
      "projectSettings": {
        "enabled": false
      }
    },
    // The ID of the organization this account belongs to
    "organizationId": "40b59978-7e87-4129-aceb-cf9a98c36c62",
    // Extra data about the organization this account belongs to
    "organizationData": {
      "name": "Example Co.",
      "disabled": false,
      "stripeId": null,
      "paid": false,
      "trialEnd": "2019-01-15T00:00:00Z",
      "projectSettings": {
        "enabled": false
      }
    }
  },
  ...
]
```

Lists all accounts that belong to an organization

### HTTP Request

`GET https://api.bluematador.com/zi/organization/<organization_id>/accounts`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
organization_id | UUID | the ID of your organization





## Create Account

> Create Account Example

```shell
curl -X POST -H "Content-Type: application/json" \
  -d '{"name": "Subsidiary 1"}' \
  "https://api.bluematador.com/zi/organization/40b59978-7e87-4129-aceb-cf9a98c36c62/accounts"
```

> Example Response: 200 OK

```json-doc
{
  // The newly created account object
  "account": {
    // The ID of this account
    "id": "a976a6af-cf87-4dd1-942f-b13a30be9351",
    "created": "2019-01-01T00:00:00Z",
    "data": {
      "stripeId": null,
      // The name given to this account
      "company": "Subsidiary 1",
      "disabled": false,
      "paid": false,
      "trialEnd": "2019-01-15T00:00:00Z",
      "assessment": null,
      "trialWalled": false,
      "projectSettings": {
        "enabled": false
      }
    },
    // The ID of the organization this account belongs to
    "organizationId": "40b59978-7e87-4129-aceb-cf9a98c36c62",
    // Extra data about the organization this account belongs to
    "organizationData": {
      "name": "Example Co.",
      "disabled": false,
      "stripeId": null,
      "paid": false,
      "trialEnd": "2019-01-15T00:00:00Z",
      "projectSettings": {
        "enabled": false
      }
    }
  },
  // The automatically created default API key for the account, so you can begin immediately calling the account-specific APIs
  "defaultApiKey": "D6bSkilgbSVm8djsMcMkrcD4QbCJ0n35"
}
```

Creates a new account for the organization.

### HTTP Request

`POST https://api.bluematador.com/zi/organization/<organization_id>/accounts`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
organization_id | UUID | the ID of your organization

### Request Body

Name | Type | Description
---- | ---- | -----------
name | string | the display name for the account, will populate the `company` field in the account data




## List Users

> List Users Example

```shell
curl https://api.bluematador.com/zi/organization/40b59978-7e87-4129-aceb-cf9a98c36c62/users
```

> Example Response: 200 OK

```json-doc
[
  {
    // The ID of the user
    "id": "dd0a2a8b-62f2-48b5-8039-75552ff0a477",
    "firstName": "John",
    "lastName": "Smith",
    "email": "johnsmith@example.com",
    "created": "2019-01-01T00:00:00Z",
    // The last time the user has logged in to Blue Matador
    "lastLogin": "2019-01-01T00:00:00Z",
    "deleted": null,
    "data": {
      "systemPermissions": [],
      "digestFrequency": "weekly",
      "lastDigest": null
    },
    "needsTour": true
  }
]
```

Lists all users that belong to an organization. The response from this endpoint includes only basic user information and does not show the user's permissions with any accounts or organization. To retrieve those details, use the [Get User](#get-user) endpoint.

### HTTP Request

`GET https://api.bluematador.com/zi/organization/<organization_id>/users`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
organization_id | UUID | the ID of your organization





## Invite User

> Invite User Example

```shell
curl -X POST -H "Content-Type: application/json" \
  -d '{
    "email": "janedoe@example.com",
    "data": {
      "permissions": ["user"],
      "autoProvision": true,
      "autoProvisionPermissions": ["user"]
    }
  }' \
  "https://api.bluematador.com/zi/organization/40b59978-7e87-4129-aceb-cf9a98c36c62/users"
```

> Example Response: 200 OK

```shell
(no body)
```

> Example Response: 409 Conflict

```json-doc
{
  "error": "a user with this email already exists"
}
```

Sends an invitation to a user to join your organization. The user must then check their email and accept the invitation through the link in their email, which leads them through the process of setting up their name and password. Invitations cannot be accepted programmatically on behalf of a user.

### HTTP Request

`POST https://api.bluematador.com/zi/organization/<organization_id>/users`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
organization_id | UUID | the ID of your organization

### Request Body

Name | Type | Description
---- | ---- | -----------
email | string | the user's email address
data | object | the user organization settings as described below

### User Organization Settings

Name | Type | Description
---- | ---- | -----------
permissions | list | a list of user organization permissions: `user` and/or `admin`
autoProvision | boolean | if set to true, the user will be provisioned onto all existing and future accounts in the organization
autoProvisionPermissions | list | a list of user account permissions: `user` and/or `admin` that the user is provisioned with when autoProvision is `true`






## Get User

> Get User Example

```shell
curl https://api.bluematador.com/zi/organization/40b59978-7e87-4129-aceb-cf9a98c36c62/users/dd0a2a8b-62f2-48b5-8039-75552ff0a477
```

> Example Response: 200 OK

```json-doc
[
  {
    // Basic user information
    "user": {
      // The ID of the user
      "id": "dd0a2a8b-62f2-48b5-8039-75552ff0a477",
      "firstName": "John",
      "lastName": "Smith",
      "email": "johnsmith@example.com",
      "created": "2019-01-01T00:00:00Z",
      // The last time the user has logged in to Blue Matador
      "lastLogin": "2019-01-01T00:00:00Z",
      "deleted": null,
      "data": {
        "systemPermissions": [],
        "digestFrequency": "weekly",
        "lastDigest": null
      },
      "needsTour": true
    },
    // An object describing this user's permissions and settings in the organization
    "userOrganization": {
      "userId": "dd0a2a8b-62f2-48b5-8039-75552ff0a477",
      "organizationId": "40b59978-7e87-4129-aceb-cf9a98c36c62",
      "data": {
        // Permissions the user has with the organization
        "permissions": [
          "user",
          "admin"
        ],
        // If true, the user is automatically provisioned onto new organization accounts
        "autoProvision": true,
        // If autoProvision is set, which permissions the user will have on new accounts
        "autoProvisionPermissions": [
          "user"
        ]
      },
      "created": "2019-01-01T00:00:00Z"
    },
    // An array of objects describing the user's permissions on each account they have permissions on
    "userAccounts": [
      {
        "userId": "dd0a2a8b-62f2-48b5-8039-75552ff0a477",
        "accountId": "a976a6af-cf87-4dd1-942f-b13a30be9351",
        "data": {
          // If true, this relationship was created as a result of auto provisioning
          "autoProvisioned": false,
          // The current permissions the user has on this account
          "permissions": [
            "user",
            "admin"
          ]
        },
        // The last time the user logged in to this account
        "lastLogin": null,
        "created": "2019-01-01T00:00:00Z"
      }
    ]
  }
]
```

> Example Response: 404 Not Found

```shell
(no body)
```

Lists all users that belong to an organization. The response from this endpoint includes only basic user information and does not show the user's permissions with any accounts or organization. To retrieve those details, use the [Get User](#get-user) endpoint.

### HTTP Request

`GET https://api.bluematador.com/zi/organization/<organization_id>/users/<user_id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
organization_id | UUID | the ID of your organization
user_id | UUID | the ID of the user





## Update User

> Update User Example

```shell
curl -X PUT -H "Content-Type: application/json" \
  -d '{
    "permissions": ["user"],
    "autoProvision": true,
    "autoProvisionPermissions": ["user"]
  }' \
  "https://api.bluematador.com/zi/organization/40b59978-7e87-4129-aceb-cf9a98c36c62/users/dd0a2a8b-62f2-48b5-8039-75552ff0a477"
```

> Example Response: 200 OK

```shell
(no body)
```

Updates a user's organization permissions.

<aside class="warning">Modifying a user's autoProvision settings does not update their existing permissions with each account in the organization.</aside>

### HTTP Request

`POST https://api.bluematador.com/zi/organization/<organization_id>/users/<user_id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
organization_id | UUID | the ID of your organization
user_id | UUID | the ID of the user

### Request Body

Name | Type | Description
---- | ---- | -----------
permissions | list | a list of user organization permissions: `user` and/or `admin`
autoProvision | boolean | if set to true, the user will be provisioned onto all existing and future accounts in the organization
autoProvisionPermissions | list | a list of user account permissions: `user` and/or `admin` that the user is provisioned with when autoProvision is `true`






## Delete User

> Delete User Example

```shell
curl -X DELETE "https://api.bluematador.com/zi/organization/40b59978-7e87-4129-aceb-cf9a98c36c62/users/dd0a2a8b-62f2-48b5-8039-75552ff0a477"
```

> Example Response: 200 OK

```shell
(no body)
```

Deletes a user from your organization. The user will also be deleted from all accounts in your organization that they had access to.

<aside class="warning">This action is permanent. Deleted users cannot be recovered, but the user can be re-invited via their email.</aside>

### HTTP Request

`DELETE https://api.bluematador.com/zi/organization/<organization_id>/users/<user_id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
organization_id | UUID | the ID of your organization
user_id | UUID | the ID of the user





## Set User Account

> Set User Account Example

```shell
curl -X PUT -H "Content-Type: application/json" \
  -d '{
    "permissions": ["user", "admin"]
  }' \
  "https://api.bluematador.com/zi/organization/40b59978-7e87-4129-aceb-cf9a98c36c62/users/dd0a2a8b-62f2-48b5-8039-75552ff0a477/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351"
```

> Example Response: 200 OK

```shell
(no body)
```

Sets a user's permissions with a specific account in your organization. To remove a user's access to an account in your organization, use the [Delete User Account](#delete-user-account) API.

<aside class="notice">A user needs at least the "user" permissions to view data for an account.</aside>

### HTTP Request

`PUT https://api.bluematador.com/zi/organization/<organization_id>/users/<user_id>/accounts/<account_id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
organization_id | UUID | the ID of your organization
user_id | UUID | the ID of the user
account_id | UUID | the ID of the account

### Request Body

Name | Type | Description
---- | ---- | -----------
permissions | list | a list of user account permissions: `user` and/or `admin`





## Delete User Account

> Delete User Account Example

```shell
curl -X DELETE "https://api.bluematador.com/zi/organization/40b59978-7e87-4129-aceb-cf9a98c36c62/users/dd0a2a8b-62f2-48b5-8039-75552ff0a477/accounts/a976a6af-cf87-4dd1-942f-b13a30be9351"
```

> Example Response: 200 OK

```shell
(no body)
```

Deletes a user's permissions with an account, completely removing all access to the account.

### HTTP Request

`DELETE https://api.bluematador.com/zi/organization/<organization_id>/users/<user_id>/accounts/<account_id>`

### Path Parameters

Name | Type | Description
---- | ---- | -----------
organization_id | UUID | the ID of your organization
user_id | UUID | the ID of the user
account_id | UUID | the ID of the account
