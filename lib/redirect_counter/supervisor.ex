defmodule RedirectCounter.Supervisor do
  use Supervisor

  def start_link do
    IO.puts "Starting #{__MODULE__}"
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    IO.puts "#{__MODULE__} Starting supervision tree"

    children = [
      worker(RedirectCounter.Count, []),
      worker(RedirectCounter.ConsoleOutput, []),
      supervisor(Task.Supervisor, [[name: :counter_supervisor, shutdown: :brutal_kill, max_restarts: 0, max_seconds: 1]]),
      worker(Task, [RedirectCounter.Counter, :count, []])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
