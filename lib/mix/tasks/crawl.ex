# lib/mix/tasks/crawl.ex
defmodule Mix.Tasks.Crawl do
  use Mix.Task

  def run([]) do
    run ["http://postd.cc"]
  end

  def run(args) do
    Mix.Task.run "app.start"
    TokyoexHandsonDemo.Crawler.Storage.start_link
    crawl args
  end

  def crawl([url, depth | tail]) do
    {depth, tail} = case Integer.parse(depth) do
      {integer, _remainder_of_binary} -> {integer, tail}
      :error -> tail = {1, [depth | tail]}
    end
    {:ok, pattern} = "^" <> Regex.escape("#{url}/") <> ".*\/$" |> Regex.compile
    TokyoexHandsonDemo.Crawler.Engine.crawl(url, depth, pattern)
    TokyoexHandsonDemo.Crawler.Storage.store_to_db
    crawl(tail)
  end

  def crawl([url]) do
    crawl [url, "1"]
  end

  def crawl([]) do
    :ok
  end
end

