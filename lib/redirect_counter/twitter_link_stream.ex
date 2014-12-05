defmodule RedirectCounter.TwitterLinkStream do
  use GenServer

  def start_link do
    GenServer.start_link __MODULE__, [], name: __MODULE__
  end

  def stream do
    GenServer.cast __MODULE__, :stream
  end

  def init(_) do
    { :ok, nil }
  end

  def handle_cast(:stream, state) do
    RedirectCounter.Twitter.links
    |> Enum.each(&RedirectCounter.URL.process/1)
    { :noreply, state }
  end
end
