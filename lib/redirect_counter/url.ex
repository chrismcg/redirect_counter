defmodule RedirectCounter.URL do
  def process(url) do
    Task.Supervisor.start_child(:counter_supervisor, __MODULE__, :count_redirects, [url])
  end

  def count_redirects(url) do
    { :ok, response } = HTTPoison.head(url)
    redirect_count = do_count(response.status_code, response.headers["Location"], 0)
    RedirectCounter.Count.log(redirect_count)
  end

  defp do_count(status_code, url, redirect_count) when status_code in [301, 302, 307] do
    { :ok, response } = HTTPoison.head(url)
    do_count(response.status_code, response.headers["Location"], redirect_count + 1)
  end

  defp do_count(_status_code, _url, redirect_count) do
    redirect_count
  end
end
