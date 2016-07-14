#!/usr/bin/env mix-snippet
#
# mix run snippets/001-crawl.exs
# iex -S mix run snippets/001-crawl.exs

url = "http://postd.cc"
depth = 1
{:ok, pattern} = "^" <> Regex.escape("#{url}/") <> ".*\/$" |> Regex.compile
TokyoexHandsonDemo.Crawler.Storage.start_link
TokyoexHandsonDemo.Crawler.Engine.crawl(url, depth, pattern)
TokyoexHandsonDemo.Crawler.Storage.store_to_db

