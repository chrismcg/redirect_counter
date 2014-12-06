defmodule RedirectCounter.Event do
  def start_link do
    GenEvent.start_link(name: __MODULE__)
  end

  def add_handler(handler, args) do
    GenEvent.add_handler(__MODULE__, handler, args)
  end

  def delete_handler(handler, args) do
    GenEvent.delete_handler(__MODULE__, handler, args)
  end

  def url(url) do
    GenEvent.notify(__MODULE__, { :url, url })
  end
end
