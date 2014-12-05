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
      supervisor(Task.Supervisor, [[name: :counter_supervisor]]),
      worker(Task, [RedirectCounter.Twitter, :process, [&RedirectCounter.URL.process/1]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
