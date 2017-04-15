# Rails - Week 4 Day 1

## What is an API?
`GET /cats` returns data whether it be in `JSON` or `HTML`

Useful for:
- Mobile Apps
- Server <-> Server communication
- Single Page Apps (client side rendering of data)

## HTTP Request and Response

#### Clients send requests and Servers send responses
#### A request has:
  - Methods
    - GET, PUT, POST, DELETE
  - Path
    - ex: `/users/4`
  - Query
    - ex: `?name=cat`
  - Body
    - additional data, ex:
      - email address
      - passwords

#### A response has:
  - Status codes
    - ex: `404 NOT FOUND`, `200 OK`
  - Body
    - Data that goes back to the client (`JSON` and etc..)

## Rails Routing
