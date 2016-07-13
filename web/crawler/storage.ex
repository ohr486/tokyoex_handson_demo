defmodule TokyoexHandsonDemo.Crawler.Storage do
  def start_link do
    Agent.start_link(fn -> Map.new end, name: __MODULE__)
  end

  def has_page?(url) do
    Agent.get __MODULE__, fn map ->
      Map.has_key?(map, url)
    end
  end

  def put_page(url, pages) do
    IO.puts "--- Put " <> url <> " ---"
    Agent.update __MODULE__, fn map ->
      Map.put(map, url, pages)
    end
  end

  def clear_all do
    IO.puts "--- Clear All ---"
    Agent.update __MODULE__, fn _map ->
      Map.new
    end
  end

  def keys do
    IO.puts "--- Show Keys ---"
    Agent.get __MODULE__, fn map ->
      Map.keys(map)
    end
  end

  def dump do
    IO.puts "--- Dump All ---"
    Agent.get __MODULE__, fn map ->
      map
    end
  end

  def store_to_db do
    IO.puts "--- Save storage to DB ---"
    dump
    |> Enum.each(fn {url, data} ->
      store_article_to_db(url, data)
    end)
  end

  def store_article_to_db(url, data) do
    try do
      if TokyoexHandsonDemo.Article.exist_with_url(url) do
        IO.puts "#{url} is arleady inserted!"
      else
        TokyoexHandsonDemo.Repo.insert!(%TokyoexHandsonDemo.Article{
          url: url, 
          title: data |> Map.get(:title),
          og_title: data |> Map.get(:og_title),
          og_image: data |> Map.get(:og_image),
          og_description: data |> Map.get(:og_description)
        })
        IO.puts "#{url} is inserted!"
      end
    rescue
      _ -> IO.puts "#{url} is rescued!"
    end 
  end
end
