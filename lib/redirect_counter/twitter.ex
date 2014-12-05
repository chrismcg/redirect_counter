defmodule RedirectCounter.Twitter do
  def configure do
    ExTwitter.configure(
      consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
      consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
      access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
      access_token_secret: System.get_env("TWITTER_ACCESS_SECRET")
    )
  end

  def links do
    configure
    ExTwitter.stream_filter(track: "link")
    |> Stream.reject(fn(t) -> t.entities["urls"] == [] end)
    |> Stream.flat_map(fn(t) -> Enum.map(t.entities["urls"], fn(u) -> u["expanded_url"] end) end)
  end

  def process(fun) do
    links |> Enum.each(fun)
  end
end
