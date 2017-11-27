defmodule Elixirposts.Repo do
  use Ecto.Repo, otp_app: :elixirposts
  use Scrivener, page_size: 4

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  def execute_and_load(sql, params, model) do
    Ecto.Adapters.SQL.query!(__MODULE__, sql, params)
    |> load_into(model)
  end

  defp load_into(response, _model) do
    Enum.map(response.rows, fn row ->
      Enum.reduce(Enum.zip(response.columns, row), %{}, fn({key, value}, map) ->
        Map.put(map, String.to_atom(key), value)
      end)
    end)
  end
end
