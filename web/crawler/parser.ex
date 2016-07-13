defmodule TokyoexHandsonDemo.Crawler.Parser do
  def parse_link(body, pattern \\ ~r//) do
    body
    |> Floki.find("a[href^=http]")
    |> Floki.attribute("href")
    |> Enum.filter(fn link ->
      Regex.match?(pattern, link)
    end)
  end

  def parse_html(body) do
    {_, _, [title]} = Floki.find(body, "title") |> List.first

    og_title = Floki.find(body, "meta[property=og:title]")
               |> Floki.attribute("content")
               |> List.first

    og_description = Floki.find(body, "meta[property=og:description]")
                     |> Floki.attribute("content")
                     |> List.first

    og_image = Floki.find(body, "meta[property=og:image]")
               |> Floki.attribute("content")
               |> List.first

    %{title: title, og_title: og_title, og_description: og_description, og_image: og_image}
  end
end
