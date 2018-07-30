defmodule IfrnmessengerWeb.AuthResolver do
  alias Ifrnmessenger.Auth.User
  alias Ifrnmessenger.AuthService

  def current_user(_root, _args, _info) do
    user = %User{
      :id => Ecto.UUID.generate,
      :name => "Felipe Pontes",
      :email => "freire.pontes@academico.ifrn.edu.br",
      :registration => "20161014040014",
      :photo => "https://suap.ifrn.edu.br/media/alunos/75x100/178969.jpg"
    }
    {:ok, user}
  end

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
