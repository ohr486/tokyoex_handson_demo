defmodule TokyoexHandsonDemo.Article do
  use TokyoexHandsonDemo.Web, :model

  schema "articles" do
    field :title, :string
    field :url, :string
    field :og_title, :string
    field :og_image, :string
    field :og_description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :url, :og_title, :og_image, :og_description])
    |> validate_required([:title, :url, :og_title, :og_image, :og_description])
  end

  def exist_with_url(url) do
    q = Ecto.Query.from(a in __MODULE__, where: a.url == ^url)
    TokyoexHandsonDemo.Repo.all(q) |> Enum.count > 0
  end
end
