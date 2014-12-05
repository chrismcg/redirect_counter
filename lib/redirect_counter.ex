defmodule RedirectCounter do
  use Application

  def start(_type, _args) do
    RedirectCounter.Supervisor.start_link
  end
end
