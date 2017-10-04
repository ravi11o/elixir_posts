defmodule Elixirposts.Index do
  @moduledoc """
  The Index context.
  """

  import Ecto.Query, warn: false
  alias Elixirposts.Repo

  alias Elixirposts.Index.Featured

  @doc """
  Returns the list of featured.

  ## Examples

      iex> list_featured()
      [%Featured{}, ...]

  """
  def list_featured do
    Repo.all(Featured)
  end

  def list_featured_with_page(params) do
    Featured
    |> order_by([p], desc: p.inserted_at)
    |> Repo.paginate(params)

  end

  @doc """
  Gets a single featured.

  Raises `Ecto.NoResultsError` if the Featured does not exist.

  ## Examples

      iex> get_featured!(123)
      %Featured{}

      iex> get_featured!(456)
      ** (Ecto.NoResultsError)

  """
  def get_featured!(id), do: Repo.get!(Featured, id)

  @doc """
  Creates a featured.

  ## Examples

      iex> create_featured(%{field: value})
      {:ok, %Featured{}}

      iex> create_featured(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_featured(attrs \\ %{}) do
    %Featured{}
    |> Featured.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a featured.

  ## Examples

      iex> update_featured(featured, %{field: new_value})
      {:ok, %Featured{}}

      iex> update_featured(featured, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_featured(%Featured{} = featured, attrs) do
    featured
    |> Featured.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Featured.

  ## Examples

      iex> delete_featured(featured)
      {:ok, %Featured{}}

      iex> delete_featured(featured)
      {:error, %Ecto.Changeset{}}

  """
  def delete_featured(%Featured{} = featured) do
    Repo.delete(featured)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking featured changes.

  ## Examples

      iex> change_featured(featured)
      %Ecto.Changeset{source: %Featured{}}

  """
  def change_featured(%Featured{} = featured) do
    Featured.changeset(featured, %{})
  end
end
