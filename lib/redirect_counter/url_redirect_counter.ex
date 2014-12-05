defmodule RedirectCounter.URLRedirectCounter do
  use GenServer

  def process(url) do
    {:ok, pid} = RedirectCounter.CounterSupervisor.start_child(url)
    GenServer.cast(pid, :count)
  end

  def start_link(url) do
    GenServer.start_link(__MODULE__, url)
  end

  def init(url) do
    { :ok, url }
  end

  def handle_cast(:count, url) do
    redirect_count = RedirectCounter.URL.count_redirects(url)
    RedirectCounter.Count.log(redirect_count)
    { :stop, :normal, url }
  end
end
