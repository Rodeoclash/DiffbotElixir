defmodule Diffbot.ClientTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Diffbot.Client
  doctest Diffbot.Client

  test "stores token" do
    expected = "1234"
    client = new("1234")
    assert client.token == expected
  end

  test "has default endpoint" do
    expected = "http://api.diffbot.com/v3"
    client = new("1234")
    assert client.endpoint == expected
  end
end
