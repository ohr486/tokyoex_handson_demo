defmodule TokyoexHandsonDemo.ListController do
  use TokyoexHandsonDemo.Web, :controller

  def index(conn, _params) do
    my_list = TokyoexHandsonDemo.Repo.all(TokyoexHandsonDemo.Article)
    render conn, "index.html", list: my_list
  end
end
