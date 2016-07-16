#!/usr/bin/env mix-snippet
#
# Usage:
#   mix run snippets/002-crawl-arg.exs [url [depth] url [depth] ...]
#   iex -S mix run snippets/002-crawl-arg.exs [url [depth] url [depth] ...]
#   iex -S mix
#     iex(1)> c "snippets/002-crawl-arg.exs"

defmodule Script do
  def main([]) do
    main ["http://postd.cc"]
  end

  def main(args) do
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

Script.main(System.argv)

