defmodule IfrnmessengerWeb.Schema do
  use Absinthe.Schema

  alias IfrnmessengerWeb.AuthResolver

  object :user dogst
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :registration, non_null(:string)
    field :photo, non_null(:string)
  end

  query do
    field :current_user, non_null(:user) do
      resolve &AuthResolver.current_user/3
    end
  end
end
