defmodule RedirectCounter.URLListener do
  use GenEvent

  def listen do
    RedirectCounter.Event.add_handler(__MODULE__, [])
  end

  def handle_event({:url, url}, state) do
    Task.Supervisor.start_child(:counter_supervisor, RedirectCounter.URL, :count_redirects, [url])
    { :ok, state }
  end
end
