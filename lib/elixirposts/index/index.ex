defmodule Elixirposts.Index do
  @moduledoc """
  The Index context.
  """

  import Ecto.Query, warn: false
  alias Elixirposts.Repo

  alias Elixirposts.Index.Post

  @doc """
  Returns the list of Post.

  ## Examples

      iex> list_Post()
      [%Post{}, ...]

  """
  def list_post do
    Repo.all(Post)
  end

  def list_featured_with_page(params) do
    Post
    |> order_by([p], desc: p.inserted_at)
    |> where([p], p.featured == true)
    |> Repo.paginate(params)

  end

  def get_subtopic_list(%{"subtopic" => subtopic} = params) do
    Post
    |> order_by([p], desc: p.inserted_at)
    |> where([p], p.subtopic == ^subtopic)
    |> Repo.paginate(params)
  end

  @doc """
  Gets a single Post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_Post!(123)
      %Post{}

      iex> get_Post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a Post.

  ## Examples

      iex> create_Post(%{field: value})
      {:ok, %Post{}}

      iex> create_Post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a Post.

  ## Examples

      iex> update_Post(Post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_Post(Post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_Post(Post)
      {:ok, %Post{}}

      iex> delete_Post(Post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Post changes.

  ## Examples

      iex> change_Post(Post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end
