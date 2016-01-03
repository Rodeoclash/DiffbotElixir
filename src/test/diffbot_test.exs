defmodule DiffbotTest do
  require Logger

  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Diffbot
  doctest Diffbot

  @client Diffbot.Client.new("1eebb0aac504effe1625023139416128")

  test "process_response/1 - status code 200" do
    expected = %{"hello" => "world"}
    response = %HTTPoison.Response{
      status_code: 200,
      headers: %{},
      body: "{\"hello\": \"world\"}"
    }
    assert process_response(response) == expected
  end

  test "process_response/1 - status code 400" do
    expected = {400, %{"hello" => "world"}}
    response = %HTTPoison.Response{
      status_code: 400,
      headers: %{},
      body: "{\"hello\": \"world\"}"
    }
    assert process_response(response) == expected
  end

  test "get/3" do
    use_cassette "diffbot#get/3" do
      response = get(@client, "/product", [url: "http://www.windsorsmith.com.au/blazor-136424"])
      objects = response["objects"]
      assert length(objects) === 1
      object = List.first(objects)     
      assert object["availability"] == true
      assert object["brand"] == "Blazor"
    end
  end
end
