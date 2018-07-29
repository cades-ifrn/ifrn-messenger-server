defmodule IfrnmessengerWeb.Router do
  use IfrnmessengerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug.GraphiQL,
      schema: IfrnmessengerWeb.Schema,
      inferface: :simple,
      context: %{pubsub: IfrnmessengerWeb.Endpoint}
  end
end
