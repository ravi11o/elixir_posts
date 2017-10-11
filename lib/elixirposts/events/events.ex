defmodule Elixirposts.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias Elixirposts.Repo

  alias Elixirposts.Events.Conferences

  @doc """
  Returns the list of conference.

  ## Examples

      iex> list_conference()
      [%Conferences{}, ...]

  """
  def list_conference do
    Repo.all(Conferences)
  end

  @doc """
  Gets a single conferences.

  Raises `Ecto.NoResultsError` if the Conferences does not exist.

  ## Examples

      iex> get_conferences!(123)
      %Conferences{}

      iex> get_conferences!(456)
      ** (Ecto.NoResultsError)

  """
  def get_conferences!(id), do: Repo.get!(Conferences, id)

  @doc """
  Creates a conferences.

  ## Examples

      iex> create_conferences(%{field: value})
      {:ok, %Conferences{}}

      iex> create_conferences(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_conferences(attrs \\ %{}) do
    %Conferences{}
    |> Conferences.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a conferences.

  ## Examples

      iex> update_conferences(conferences, %{field: new_value})
      {:ok, %Conferences{}}

      iex> update_conferences(conferences, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_conferences(%Conferences{} = conferences, attrs) do
    conferences
    |> Conferences.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Conferences.

  ## Examples

      iex> delete_conferences(conferences)
      {:ok, %Conferences{}}

      iex> delete_conferences(conferences)
      {:error, %Ecto.Changeset{}}

  """
  def delete_conferences(%Conferences{} = conferences) do
    Repo.delete(conferences)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking conferences changes.

  ## Examples

      iex> change_conferences(conferences)
      %Ecto.Changeset{source: %Conferences{}}

  """
  def change_conferences(%Conferences{} = conferences) do
    Conferences.changeset(conferences, %{})
  end
end
