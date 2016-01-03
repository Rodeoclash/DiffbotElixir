defmodule Diffbot.ProductTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Diffbot.Product
  doctest Diffbot.Product

  @client Diffbot.Client.new("1eebb0aac504effe1625023139416128")

  setup_all do
    HTTPoison.start
  end

  test "request/2" do
    use_cassette "product#request/2" do
      response = request(@client, "http://www.windsorsmith.com.au/blazor-136424")
      objects = response["objects"]
      assert length(objects) === 1
      object = List.first(objects)     
      assert object["availability"] == true
      assert object["brand"] == "Blazor"
    end
  end

end
