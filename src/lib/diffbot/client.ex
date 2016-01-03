defmodule Diffbot.Client do
  require Logger

  defstruct token: nil, endpoint: "http://api.diffbot.com/v3"

  def new(token) do
    %__MODULE__{token: token}
  end

end
