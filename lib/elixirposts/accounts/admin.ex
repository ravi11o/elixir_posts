defmodule Elixirposts.Accounts.Admin do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixirposts.Accounts.Admin
  import Comeonin.Bcrypt


  schema "admins" do
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string

    timestamps()
  end

  @doc false
  def changeset(%Admin{} = admin, attrs) do
    admin
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :hashed_password, hashpwsalt(password))
      _ -> changeset
    end
  end
end
