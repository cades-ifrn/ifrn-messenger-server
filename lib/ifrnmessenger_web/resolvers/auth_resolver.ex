defmodule IfrnmessengerWeb.AuthResolver do
  alias Ifrnmessenger.Auth.User
  alias Ifrnmessenger.AuthService

  def current_user(_root, _args, %{context: %{current_user: user}}), do: {:ok, user}
  def current_user(_root, _args, _info), do: {:error, "Not authenticated."}

  def obtain_token(_root, args, _info) do
    with {:ok, token} <- AuthService.obtain_token(args[:username], args[:password]) do
      {:ok, %{:token => token}}
    end
  end

  def refresh_token(_root, args, _info) do
    with {:ok, token} <- AuthService.refresh_token(args[:token]) do
      {:ok, %{:token => token}}
    end
  end
end
