defmodule Ifrnmessenger.AuthService do
  @moduledoc """
  The Auth service.
  """

  alias Ifrnmessenger.SuapService
  alias Ifrnmessenger.Auth
  alias Ifrnmessenger.Auth.User
  alias Ifrnmessenger.Auth.Guardian

  def obtain_token(username, password) do
    with {:ok, token} <- SuapService.token(username, password) do
      user = Auth.get_user_by_registration(username)

      if user != nil do
        with {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
          {:ok, token}
        end
      else
        with {:ok, data} <- SuapService.about(token) do
          with {:ok, user} <- Auth.create_user(%{
            :name => data[:nome_usual],
            :email => data[:email],
            :registration => data[:matricula],
            :photo => "https://suap.ifrn.edu.br" <> data[:url_foto_75x100]
          }) do
            # TODO: load classes and create conversations
            with {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
              {:ok, token}
            end
          end
        end
      end
    end
  end

  def refresh_token(token) do
    with {:ok, _old, {token, _claims}} <- Guardian.refresh(token) do
      {:ok, token}
    end
  end
end
