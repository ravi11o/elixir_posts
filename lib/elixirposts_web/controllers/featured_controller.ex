defmodule ElixirpostsWeb.FeaturedController do
  use ElixirpostsWeb, :controller

  alias Elixirposts.Index
  alias Elixirposts.Index.Featured

  def index(conn, _params) do
    featured = Index.list_featured()
    render(conn, "index.html", featured: featured)
  end

  def new(conn, _params) do
    changeset = Index.change_featured(%Featured{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"featured" => featured_params}) do
    case Index.create_featured(featured_params) do
      {:ok, featured} ->
        conn
        |> put_flash(:info, "Featured created successfully.")
        |> redirect(to: featured_path(conn, :show, featured))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    featured = Index.get_featured!(id)
    render(conn, "show.html", featured: featured)
  end

  def edit(conn, %{"id" => id}) do
    featured = Index.get_featured!(id)
    changeset = Index.change_featured(featured)
    render(conn, "edit.html", featured: featured, changeset: changeset)
  end

  def update(conn, %{"id" => id, "featured" => featured_params}) do
    featured = Index.get_featured!(id)

    case Index.update_featured(featured, featured_params) do
      {:ok, featured} ->
        conn
        |> put_flash(:info, "Featured updated successfully.")
        |> redirect(to: featured_path(conn, :show, featured))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", featured: featured, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    featured = Index.get_featured!(id)
    {:ok, _featured} = Index.delete_featured(featured)

    conn
    |> put_flash(:info, "Featured deleted successfully.")
    |> redirect(to: featured_path(conn, :index))
  end
end
