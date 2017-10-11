defmodule Elixirposts.Repo.Migrations.CreateConference do
  use Ecto.Migration

  def change do
    create table(:conference) do
      add :title, :string
      add :year, :integer
      add :location, :string
      add :start_date, :date
      add :end_date, :date
      add :fixed_date, :date
      add :country, :string

      timestamps()
    end

  end
end
