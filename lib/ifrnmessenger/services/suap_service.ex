defmodule Ifrnmessenger.SuapService do
  @moduledoc """
  The SUAP API Client service.
  """

  defp url(endpoint), do: "https://suap.ifrn.edu.br/api/v2" <> endpoint

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

    case HTTPoison.post(
      url("/autenticacao/token/"),
      body,
      [{"Content-Type", "application/json"}]
    ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, parse_object(body)[:token]}
      {:ok, _} ->
        {:error, "Username and password does not match."}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def about(token) do
    case  HTTPoison.get(
      url("/minhas-informacoes/meus-dados/"),
      [{"Content-Type", "application/json"}, {"Authorization", "JWT " <> token}]
    ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, parse_object(body)}
      {:ok, _} ->
        {:error, "The user was not found."}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def semesters(token) do
    # TODO: handle errors

    {:ok, response} =
      HTTPoison.get(
        url("/minhas-informacoes/meus-periodos-letivos/"),
        [{"Content-Type", "application/json"}, {"Authorization", "JWT " <> token}]
      )

    parse_list(response.body)
  end

  def classes(token, year, semester) do
    # TODO: handle errors

    {:ok, response} =
      HTTPoison.get(
        url("/minhas-informacoes/turmas-virtuais/" <> year <> "/" <> semester <> "/"),
        [{"Content-Type", "application/json"}, {"Authorization", "JWT " <> token}]
      )

    parse_list(response.body)
  end
end
