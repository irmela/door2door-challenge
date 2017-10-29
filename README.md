# README

## Setup

* `git clone git@github.com:irmela/door2door-challenge.git`
* `cd door2door-challenge`

**a) docker**
(Performance was not very good running docker-machine on my MacBook Pro)
* `docker-compose build`
* `docker-compose run web rails db:setup`
* `docker-compose up`

**b) non-docker**
* `bundle install`
* `bin/rails db:setup`
* `bin/rails s`

**driver-simulator**
* Use [my fork](https://github.com/irmela/fullstack-code-challenge) of the driver-simulator. See [PR #6](https://github.com/door2door-io/fullstack-code-challenge/pull/6)

## Stack
I used **rails 5** since this is my framework of choice. The map is build with **leaflet** because it's flexible and well documented and I already has some experience with it. Although I think it could have been easily done without react, I wrapped it in a **react** component because for future features I think using react would be an advantage and of course because I was curiouse to learn more react.

## What's missing
As next steps I would work on the following:
* Add frontend specs
* Only update/rebuild map when state.vehicle changed
* Improve logic to fetch new vehicle locations (ActionCable?)
* Improve performance to handle more requests

## Endpoints

#### Vehicle registration

`POST /vehicles`

Request body:

```json
{ "id": "some-uuid-here" }
```

#### Location update

`POST /vehicles/:id/locations`

Request body:

```json
{ "lat": 10.0, "lng": 20.0, "at": "2017-09-01T12:00:00Z" }
```

#### Vehicle de-registration

`DELETE /vehicles/:id`
