defmodule IfrnmessengerWeb.AuthResolver do
  alias Ifrnmessenger.Auth.User

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
end
