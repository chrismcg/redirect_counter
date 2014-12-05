defmodule RedirectCounter.Count do
  def start_link do
    IO.puts "Starting #{__MODULE__}"
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def log(redirect_count) do
    Agent.update(__MODULE__, &Map.update(&1, redirect_count, 1, fn(n) -> n + 1 end))
  end

  def get do
    Agent.get(__MODULE__, fn(map) -> map end)
  end
end
