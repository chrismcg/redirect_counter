defmodule RedirectCounter.Counter do
  def count do
    for url <- RedirectCounter.Twitter.links do
      RedirectCounter.URL.process(url)
    end
  end
end
