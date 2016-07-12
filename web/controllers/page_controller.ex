defmodule TokyoexHandsonDemo.PageController do
  use TokyoexHandsonDemo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
