defmodule Diffbot do
  require Logger
  use HTTPoison.Base

  def process_response(response) do
    status_code = response.status_code
    body = response.body
    response = unless body == "", do: body |> JSX.decode!, else: nil
    if (status_code == 200), do: response, else: {status_code, response}
  end

  def get(client, path, params) do
    params = params ++ [token: client.token]
    query_params = query_params(params)
    url = url(client, path)
    url = <<url :: binary, query_params :: binary>>
    request!(:get, url) |> process_response
  end

  defp url(client, path) do
    "#{client.endpoint}#{path}"
  end

  defp query_params(params) do
    "?#{URI.encode_query params}"
  end

end
