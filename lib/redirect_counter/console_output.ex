defmodule RedirectCounter.ConsoleOutput do
  use GenServer

  @timeout 1000

  def start_link do
    GenServer.start_link __MODULE__, [], name: __MODULE__
  end

  def init(_) do
    { :ok, nil, @timeout }
  end

  def handle_info(:timeout, state) do
    IO.inspect RedirectCounter.Count.get
    { :noreply, state, @timeout }
  end
end
