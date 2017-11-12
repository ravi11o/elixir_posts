defmodule Elixirposts.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias Elixirposts.Repo

  alias Elixirposts.Events.{Conferences, Talk}

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

  def get_conferences_by_year(year) do
    Conferences
    |> where([c], c.year == ^year)
    |> Repo.all
  end

  ################Elixirposts.Events.Talk######################

  alias Elixirposts.Events.Talk

  @doc """
  Returns the list of talks.

  ## Examples

      iex> list_talks()
      [%Talk{}, ...]

  """
  def list_talks(conference) do
    Talk
    |> where([t], t.conference_id == ^conference.id)
    |> Repo.all
  end

  def talks_by_conference_id(id) do
    Talk
    |> where([t], t.conference_id == ^id)
    |> preload(:conference)
    |> Repo.all
  end

  @doc """
  Gets a single talk.

  Raises `Ecto.NoResultsError` if the Talk does not exist.

  ## Examples

      iex> get_talk!(123)
      %Talk{}

      iex> get_talk!(456)
      ** (Ecto.NoResultsError)

  """
  def get_talk!(id), do: Repo.get!(Talk, id)

  @doc """
  Creates a talk.

  ## Examples

      iex> create_talk(%{field: value})
      {:ok, %Talk{}}

      iex> create_talk(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_talk(attrs \\ %{}, conference) do
    %Talk{conference_id: conference.id}
    |> Talk.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a talk.

  ## Examples

      iex> update_talk(talk, %{field: new_value})
      {:ok, %Talk{}}

      iex> update_talk(talk, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_talk(%Talk{} = talk, attrs) do
    talk
    |> Talk.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Talk.

  ## Examples

      iex> delete_talk(talk)
      {:ok, %Talk{}}

      iex> delete_talk(talk)
      {:error, %Ecto.Changeset{}}

  """
  def delete_talk(%Talk{} = talk) do
    Repo.delete(talk)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking talk changes.

  ## Examples

      iex> change_talk(talk)
      %Ecto.Changeset{source: %Talk{}}

  """
  def change_talk(%Talk{} = talk) do
    talk
    |> Talk.changeset(%{})
  end
end
