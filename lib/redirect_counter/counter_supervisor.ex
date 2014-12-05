defmodule RedirectCounter.CounterSupervisor do
  use Supervisor

  def start_link do
    IO.puts "Starting #{__MODULE__}"
    Supervisor.start_link __MODULE__, [], name: __MODULE__
  end

  def start_child(url) do
    Supervisor.start_child(__MODULE__, [url])
  end

  def init(_) do
    children = [
      worker(RedirectCounter.URLRedirectCounter, [], restart: :temporary, shutdown: :brutal_kill)
    ]
    options = [
      strategy: :simple_one_for_one,
      max_restarts: 0,
      max_seconds: 1
    ]
    supervise(children, options)
  end
end
