defmodule Elixirposts.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :email, :string
      add :hashed_password, :string

      timestamps()
    end

    create unique_index(:admins, [:email])
  end
end
