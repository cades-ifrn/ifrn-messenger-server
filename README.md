# IFRN Messenger [![CircleCI](https://circleci.com/gh/cades-ifrn/ifrn-messenger-server/tree/master.svg?style=svg)](https://circleci.com/gh/cades-ifrn/ifrn-messenger-server/tree/master) [![codecov](https://codecov.io/gh/cades-ifrn/ifrn-messenger-server/branch/master/graph/badge.svg)](https://codecov.io/gh/cades-ifrn/ifrn-messenger-server)


#### Docker

To start with Docker:

  * Build images with `docker-compose build`
  * Setup database with `docker-compose run app mix ecto.setup`
  * Start the server with `docker-compose up`

#### Native

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
