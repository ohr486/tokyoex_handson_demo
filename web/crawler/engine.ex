defmodule TokyoexHandsonDemo.Crawler.Engine do
  require Logger

  def get_site(url) do
    Logger.debug "### Get #{url} ###"
    %{body: body} = HTTPoison.get!(url)
    body
  end

  def crawl(url, 0, _) do
    Logger.debug "### Crawl #{url} ###"
    if TokyoexHandsonDemo.Crawler.Storage.has_page?(url) do
      Logger.debug "### already putted #{url} ###"
    else
      Task.async(fn ->
        site = get_site(url) |> TokyoexHandsonDemo.Crawler.Parser.parse_html
        TokyoexHandsonDemo.Crawler.Storage.put_page(url, site)
      end)
    end
  end

  def crawl(url, depth, pattern) do
    Logger.debug "### Crawling #{url}, depth=#{inspect depth} ###"
    body = get_site(url)
    site = body |> TokyoexHandsonDemo.Crawler.Parser.parse_html

    # TODO: improve me
    TokyoexHandsonDemo.Crawler.Storage.put_page(url, site)

    TokyoexHandsonDemo.Crawler.Parser.parse_link(body, pattern)
    |> Enum.map(fn url ->
      crawl(url, (depth - 1), pattern)
    end)
    |> Enum.reject(&(&1 == :ok))
    |> Enum.each(&Task.await(&1, 10_000))
  end
end
