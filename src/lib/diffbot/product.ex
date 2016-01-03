defmodule Diffbot.Product do
  import Diffbot
  require Logger

  @path "/product"

  def request(client, url) do
    params = [url: url]
    get client, "#{@path}", params
  end

end