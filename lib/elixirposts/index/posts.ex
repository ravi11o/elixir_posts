defmodule Elixirposts.Index.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixirposts.{Index.Post, Repo}


  schema "posts" do
    field :description, :string
    field :official_url, :string
    field :package, :string, virtual: true
    field :packages, {:array, :string}
    field :tag, :string, virtual: true
    field :tags, {:array, :string}
    field :title, :string
    field :url, :string
    field :writer, :string
    field :featured, :boolean
    field :topic, :string
    field :subtopic, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :description, :writer, :tag, :package, :featured, :topic, :subtopic, :url, :official_url])
    |> validate_required([:title, :description, :writer, :url, :topic, :featured, :subtopic])
    |> unique_constraint(:title)
    |> add_tags
    |> add_features
  end

  defp add_tags(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{tag: tag}} ->
        tags =
          tag
          |> String.split([" ", ",", ", "], trim: true)
          |> Enum.map(&(String.capitalize(&1)))
        put_change(changeset, :tags, tags)
      _ -> changeset
    end
  end

  defp add_features(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{package: package}} ->
        features =
          package
          |> String.split([" ", ",", ", "], trim: true)
          |> Enum.map(&(String.capitalize(&1)))
        put_change(changeset, :packages, features)
      _ -> changeset
    end
  end

  def search(term) do
    formatted = term |> String.replace(" ", "|")
    Repo.execute_and_load("select * from posts where id in (select searchable_id from searches
      where to_tsvector('english', term) 
      @@ to_tsquery($1));", [ formatted ], Post)
  end

end
