defmodule IfrnmessengerWeb.Router do
  use IfrnmessengerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", IfrnmessengerWeb do
    pipe_through :api
  end
end
