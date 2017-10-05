defmodule Elixirposts.Repo.Migrations.RenameTableFeatured do
  use Ecto.Migration

  def change do
    rename table(:featured), to: table(:posts)
  end
end
