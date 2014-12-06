defmodule RedirectCounter do
  use Application

  def start(_type, _args) do
    result = RedirectCounter.Supervisor.start_link
    RedirectCounter.URL.listen
    result
  end
end
