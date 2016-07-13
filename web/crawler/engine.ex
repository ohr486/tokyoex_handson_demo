defmodule TokyoexHandsonDemo.Crawler.Engine do
  def get_site(url) do
    IO.puts "Getting " <> url
    %{body: body} = HTTPoison.get!(url)
    body
  end

  def crawl(url, 0, _) do
    IO.puts "Crawl " <> url
    site = get_site(url) |> TokyoexHandsonDemo.Crawler.Parser.parse_html
    TokyoexHandsonDemo.Crawler.Storage.put_page(url, site)
  end

  def crawl(url, depth, pattern) do
    IO.puts "Crawling " <> url <> ", depth=#{inspect depth}"
    body = get_site(url)
    site = body |> TokyoexHandsonDemo.Crawler.Parser.parse_html
    TokyoexHandsonDemo.Crawler.Storage.put_page(url, site)

    links = TokyoexHandsonDemo.Crawler.Parser.parse_link(body, pattern)
            |> Enum.filter(fn link ->
              !TokyoexHandsonDemo.Crawler.Storage.has_page?(link)
            end)

    Enum.each links, fn link ->
      task = Task.async(fn -> crawl(link, (depth - 1), pattern) end)
      Task.await(task, 10000)
    end
  end
end
