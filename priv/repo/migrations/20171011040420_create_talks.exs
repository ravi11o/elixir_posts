defmodule Elixirposts.Repo.Migrations.CreateTalks do
  use Ecto.Migration

  def change do
    create table(:talks) do
      add :title, :string
      add :creator, :string
      add :tags, {:array, :string}
      add :url, :string
      add :views, :integer
      add :conference_id, references(:conference, on_delete: :nothing)

      timestamps()
    end

    create index(:talks, [:conference_id])
  end
end
