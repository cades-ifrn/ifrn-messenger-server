defmodule IfrnmessengerWeb.Schema do
  use Absinthe.Schema

  alias IfrnmessengerWeb.AuthResolver

  object :user_type do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :registration, non_null(:string)
    field :photo, non_null(:string)
  end

  object :token_type do
    field :token, non_null(:string)
  end

  query do
    field :current_user, :user_type do
      resolve &AuthResolver.current_user/3
    end
  end

  mutation do
    field :obtain_token, :token_type do
      arg :username, non_null(:string)
      arg :password, non_null(:string)

      resolve &AuthResolver.obtain_token/3
    end

    field :refresh_token, :token_type do
      arg :token, non_null(:string)

      resolve &AuthResolver.refresh_token/3
    end
  end
end
