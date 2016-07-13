defmodule TokyoexHandsonDemo.Crawler.Engine do
  def get_site(url) do
    IO.puts "### Get " <> url <> " ###"
    %{body: body} = HTTPoison.get!(url)
    body
  end

  def crawl(url, 0, _) do
    IO.puts "### Crawl " <> url <> " ###"
    if TokyoexHandsonDemo.Crawler.Storage.has_page?(url) do
      IO.puts "### already putted " <> url <> " ###"
    else
      Task.async(fn ->
        site = get_site(url) |> TokyoexHandsonDemo.Crawler.Parser.parse_html
        TokyoexHandsonDemo.Crawler.Storage.put_page(url, site)
      end)
      |> Task.await(10000)
    end
  end

  def crawl(url, depth, pattern) do
    IO.puts "### Crawling " <> url <> ", depth=#{inspect depth} ###"
    body = get_site(url)
    site = body |> TokyoexHandsonDemo.Crawler.Parser.parse_html

    # TODO: improve me 
    TokyoexHandsonDemo.Crawler.Storage.put_page(url, site)

    TokyoexHandsonDemo.Crawler.Parser.parse_link(body, pattern)
    |> Enum.each(fn url ->
      crawl(url, (depth - 1), pattern)
    end)
  end
end
