
# Munso Push Server

[![pushd](https://img.shields.io/badge/based%20on-pushd-blue.svg?style=flat-square)](https://github.com/rs/pushd)

Installation
------------

- Clone this repository
- Install dependancies: `npm install`
- Configure the server in: `cp settings-sample.coffee settings.coffee && vi settings.coffee`
- Start redis: `redis-server`
- Start the server: `coffee pushd.coffee`

API
---

You can find more detailed informations about [pushd API on GitHub](https://github.com/rs/pushd#api)

## Subscriber Registration

### Register a subscriber

POST on `/subscribers`

With following parameters:

- `proto`: The protocol to be used for the subscriber. Use one of the following values:
	- `apns`: iOS (Apple Push Notification service)
	- `gcm` or `c2dm`: Android (Cloud to subscriber Messaging)
	- `mpns` Window Phone (Microsoft Push Notification Service)
- `token`: The device registration id delivered by the platform's push notification service

### Update subscriber informations

POST on `/subscriber/SUBSCRIBER_ID`

On each app launch, it is highly recommended to update your subscriber information in order to inform pushd your subscriber is still alive and registered for notifications.

### Subscribe/Unsubscribe to an Event

POST/DELETE on `/subscriber/SUBSCRIBER_ID/subscriptions/EVENT_NAME`

For pushd, an event is represented as a simple string. By default a subscriber won't receive push notifications other than broadcasts or direct messages if it’s not subscribed to events. Events are text and/or data sent by your service on pushd. Pushd's role is to convert this event into a push notification for any subscribed subscriber.

## Event Ingestion

To generate notifications, your service must send events to pushd.

### Send event

POST on `/event/EVENT_NAME`

With following parameters :
- `title`, `msg`: The event title/message.
- `data.<key>`: Key/values to be attached to the notification

> There are two specifics event names, in which case notifications can be sent without a subscription:
> - `broadcast` sends the notification to all subscribers
> - `unicast:SUBSCRIBER_ID` sends the notification to the subscriber with the specified id



Certificates
-------

For APNs certificates, you'll have to convert a `[certificate].cer` and `[key].p12` into `[certificate].pem` and `[key].pem` :

```bash
openssl x509 -in cert-prod.cer -inform DER -outform PEM -out apns-cert-prod.pem
openssl pkcs12 -in key-prod.p12 -out apns-key-prod.pem -nodes
```
