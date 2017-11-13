defmodule Elixirposts.Events.Talk do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixirposts.Events.{Talk, Conferences}


  schema "talks" do
    field :creator, :string
    field :tags, {:array, :string}
    field :title, :string
    field :url, :string
    field :views, :integer, default: 0
    belongs_to :conference, Conferences

    timestamps()
  end

  @doc false
  def changeset(%Talk{} = talk, attrs) do
    talk
    |> cast(attrs, [:title, :creator, :tags, :url, :views])
    |> validate_required([:title, :creator, :url])
  end
end
