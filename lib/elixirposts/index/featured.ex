defmodule Elixirposts.Index.Featured do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixirposts.Index.Featured


  schema "featured" do
    field :description, :string
    field :official_url, :string
    field :package, :string, virtual: true
    field :packages, {:array, :string}
    field :tag, :string, virtual: true
    field :tags, {:array, :string}
    field :title, :string
    field :url, :string
    field :writer, :string

    timestamps()
  end

  @doc false
  def changeset(%Featured{} = featured, attrs) do
    featured
    |> cast(attrs, [:title, :description, :writer, :tag, :package, :url, :official_url])
    |> validate_required([:title, :description, :writer, :url])
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

end
