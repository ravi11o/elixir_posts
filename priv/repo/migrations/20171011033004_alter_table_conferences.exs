defmodule Elixirposts.Repo.Migrations.AlterTableConferences do
  use Ecto.Migration

  def change do
    alter table(:conference) do
      modify :start_date, :string
      modify :end_date, :string
      modify :fixed_date, :string
    end
  end
end
