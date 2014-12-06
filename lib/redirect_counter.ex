defmodule RedirectCounter do
  use Application

  def start(_type, _args) do
    result = RedirectCounter.Supervisor.start_link
    RedirectCounter.URLListener.listen
    result
  end
end
