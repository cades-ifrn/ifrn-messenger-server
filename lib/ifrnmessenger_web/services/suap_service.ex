defmodule CommunityWeb.SuapService do 
    defp url(endpoint) do
        "https://suap.ifrn.edu.br/api/v2" <> endpoint
    end
    
    def token(username, password) do
        body = Poison.encode!(%{
            "username" => username,
            "password" => password,
        })

        {:ok, response} = HTTPoison.post(
            url("/autenticacao/token/"),
            body,
            [{"Content-Type", "application/json"}]
        )
        
        data = response.body
          |> Poison.decode!
          |> Map.take(~w(token))
          |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)

        data[:token]
    end
end