defmodule Elixirposts.Repo.Migrations.AddFiledsToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :featured, :boolean
      add :topic, :string
      add :subtopic, :string
    end
  end
end
