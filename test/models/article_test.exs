defmodule TokyoexHandsonDemo.ArticleTest do
  use TokyoexHandsonDemo.ModelCase

  alias TokyoexHandsonDemo.Article

  @valid_attrs %{og_description: "some content", og_image: "some content", og_title: "some content", title: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Article.changeset(%Article{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Article.changeset(%Article{}, @invalid_attrs)
    refute changeset.valid?
  end
end
