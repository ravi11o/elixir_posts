defmodule Elixirposts.Events.Conferences do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixirposts.Events.{Conferences, Talk}


  schema "conference" do
    field :country, :string
    field :end_date, :string
    field :fixed_date, :string
    field :location, :string
    field :start_date, :string
    field :title, :string
    field :year, :integer
    has_many :talks, Talk

    timestamps()
  end

  @doc false
  def changeset(%Conferences{} = conferences, attrs) do
    conferences
    |> cast(attrs, [:title, :year, :location, :start_date, :end_date, :fixed_date, :country])
    |> validate_required([:title, :year, :location, :country])
  end
end
