defmodule TokyoexHandsonDemo.Crawler.Engine do
  require Logger

  def get_site(url) do
    Logger.debug "### Get #{url} ###"
    %{body: body} = HTTPoison.get!(url)
    body
  end

  def crawl(url, depth, pattern) do
    crawl(url, url, depth, pattern)
  end

  defp crawl(url, _base_url, 0, _) do
    Logger.debug "### Crawl #{url} ###"
    if TokyoexHandsonDemo.Crawler.Storage.has_page?(url) do
      Logger.debug "### already put #{url} ###"
    else
      Task.async(fn ->
        site = get_site(url) |> TokyoexHandsonDemo.Crawler.Parser.parse_html
        TokyoexHandsonDemo.Crawler.Storage.put_page(url, site)
      end)
    end
  end

  defp crawl(url, base_url, depth, pattern) do
    Logger.debug "### Crawling #{url}, depth=#{inspect depth} ###"
    body = get_site(url)
    site = body |> TokyoexHandsonDemo.Crawler.Parser.parse_html

    # TODO: improve me
    TokyoexHandsonDemo.Crawler.Storage.put_page(url, site)

    TokyoexHandsonDemo.Crawler.Parser.parse_link(body, pattern)
    |> Enum.map(fn url ->
      url
      |> normalize_url(base_url)
      |> crawl(depth - 1, pattern)
    end)
    |> Enum.reject(&(&1 == :ok))
    |> Enum.each(&Task.await(&1, 10_000))
  end

  defp normalize_url(url, base_url) do
    if String.starts_with?(url, ".") or String.starts_with?(url, "/") do
      Path.join(base_url, url)
    else
      url
    end
  end
end
