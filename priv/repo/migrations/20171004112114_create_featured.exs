defmodule Elixirposts.Repo.Migrations.CreateFeatured do
  use Ecto.Migration

  def change do
    create table(:featured) do
      add :title, :string
      add :description, :string
      add :writer, :string
      add :tags, {:array, :string}
      add :packages, {:array, :string}
      add :url, :string
      add :official_url, :string

      timestamps()
    end

    create unique_index(:featured, [:title])
  end
end
