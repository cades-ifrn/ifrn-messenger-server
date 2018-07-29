defmodule CommunityWeb.SuapService do
  defp url(endpoint) do
    "https://suap.ifrn.edu.br/api/v2" <> endpoint
  end

  defp parse_object(body) do
    body
    |> Poison.decode!()
    |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
  end

  defp parse_list(body) do
    body
    |> Poison.decode!()
    |> Enum.map(fn x -> Enum.map(x, fn {k, v} -> {String.to_atom(k), v} end) end)
  end

  def token(username, password) do
    body =
      Poison.encode!(%{
        "username" => username,
        "password" => password
      })

    {:ok, response} =
      HTTPoison.post(
        url("/autenticacao/token/"),
        body,
        [{"Content-Type", "application/json"}]
      )

    data = parse_object(response.body)

    data[:token]
  end

  def about(token) do
    {:ok, response} =
      HTTPoison.get(
        url("/minhas-informacoes/meus-dados/"),
        [{"Content-Type", "application/json"}, {"Authentication", "Bearer " <> token}]
      )

    parse_object(response.body)
  end

  def semesters(token) do
    {:ok, response} =
      HTTPoison.get(
        url("/minhas-informacoes/meus-periodos-letivos/"),
        [{"Content-Type", "application/json"}, {"Authentication", "Bearer " <> token}]
      )

    parse_list(response.body)
  end

  def classes(token, year, semester) do
    {:ok, response} =
      HTTPoison.get(
        url("/minhas-informacoes/turmas-virtuais/" <> year <> "/" <> semester <> "/"),
        [{"Content-Type", "application/json"}, {"Authentication", "Bearer " <> token}]
      )

    parse_list(response.body)
  end
end
