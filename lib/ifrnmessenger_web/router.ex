defmodule IfrnmessengerWeb.Router do
  use IfrnmessengerWeb, :router

  pipeline :graphql do
    plug :accepts, ["json"]
    plug Guardian.Plug.Pipeline,
      module: Ifrnmessenger.Auth.Guardian,
      error_handler: IfrnmessengerWeb.GuardianErrorHandler
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource, allow_blank: true
    plug IfrnmessengerWeb.Context
  end

  scope "/" do
    pipe_through :graphql

    forward "/graphql", Absinthe.Plug.GraphiQL,
      schema: IfrnmessengerWeb.Schema,
      inferface: :simple,
      context: %{pubsub: IfrnmessengerWeb.Endpoint}
  end
end
