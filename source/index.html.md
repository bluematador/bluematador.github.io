---
title: Blue Matador API

language_tabs: # must be one of https://git.io/vQNgJ

toc_footers:

includes:
  - events
  - integrations
  - notifications
  - organizations
  - errors

search: true
---

# Introduction

> Base URL for the API

```shell
https://api.bluematador.com
```

Welcome to the [Blue Matador](https://www.bluematador.com) API. The API allows you to interact with Blue Matador resources outside of the UI. All endpoints use standard HTTP verbs, authentication, and JSON for request and response bodies.

# Authentication

> An example of authenticating with Blue Matador

```shell
curl "api_endpoint_here"
  -H "Authorization: D6bSkilgbSVm8djsMcMkrcD4QbCJ0n35"
```

> Make sure to replace `D6bSkilgbSVm8djsMcMkrcD4QbCJ0n35` with your API key

All API endpoints are scoped to an account and require an API key for access. You can retrieve an API key for an account by visiting [the in app page for API keys](https://app.bluematador.com/ur/app#/account/apikeys).

Once you have an API key, you can authenticate calls to Blue Matador by passing your API key as the value for the `Authorization` header:

`Authorization: D6bSkilgbSVm8djsMcMkrcD4QbCJ0n35`

<aside class="notice">Make sure to replace <code>D6bSkilgbSVm8djsMcMkrcD4QbCJ0n35</code> with your API key</aside>
