defmodule TokyoexHandsonDemo.Crawler.Storage do
  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def has_page?(name) do
    Agent.get __MODULE__, fn map ->
      Map.has_key?(map, name)
    end
  end

  def put_page(name, links) do
    IO.puts "--- Put " <> name
    Agent.update __MODULE__, fn map ->
      Map.put(map, name, links)
    end
  end

  def clear_all do
    IO.puts "--- Clear All"
    Agent.update __MODULE__, fn _map ->
      %{}
    end
  end

  def keys do
    IO.puts "--- Show Keys"
    Agent.get __MODULE__, fn map ->
      Map.keys(map)
    end
  end

  def dump do
    IO.puts "Dump All"
    Agent.get __MODULE__, fn map ->
      map
    end
  end
end
