defmodule TokyoexHandsonDemo.Repo.Migrations.CreateArticle do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :url, :string
      add :og_title, :string
      add :og_image, :string
      add :og_description, :text

      timestamps()
    end

  end
end
