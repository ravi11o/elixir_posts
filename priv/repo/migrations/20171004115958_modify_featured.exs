defmodule Elixirposts.Repo.Migrations.ModifyFeatured do
  use Ecto.Migration

  def change do
    alter table(:featured) do
      modify :description, :text
    end
  end
end
