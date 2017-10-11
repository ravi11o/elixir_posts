defmodule ElixirpostsWeb.ConferencesController do
  use ElixirpostsWeb, :controller

  alias Elixirposts.Events
  alias Elixirposts.Events.Conferences

  def index(conn, _params) do
    conference = Events.list_conference()
    render(conn, "index.html", conference: conference)
  end

  def new(conn, _params) do
    changeset = Events.change_conferences(%Conferences{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"conferences" => conferences_params}) do
    IO.inspect conferences_params
    case Events.create_conferences(conferences_params) do
      {:ok, conferences} ->
        conn
        |> put_flash(:info, "Conferences created successfully.")
        |> redirect(to: conferences_path(conn, :show, conferences))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    conferences = Events.get_conferences!(id)
    render(conn, "show.html", conferences: conferences)
  end

  def edit(conn, %{"id" => id}) do
    conferences = Events.get_conferences!(id)
    changeset = Events.change_conferences(conferences)
    render(conn, "edit.html", conferences: conferences, changeset: changeset)
  end

  def update(conn, %{"id" => id, "conferences" => conferences_params}) do
    conferences = Events.get_conferences!(id)

    case Events.update_conferences(conferences, conferences_params) do
      {:ok, conferences} ->
        conn
        |> put_flash(:info, "Conferences updated successfully.")
        |> redirect(to: conferences_path(conn, :show, conferences))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", conferences: conferences, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    conferences = Events.get_conferences!(id)
    {:ok, _conferences} = Events.delete_conferences(conferences)

    conn
    |> put_flash(:info, "Conferences deleted successfully.")
    |> redirect(to: conferences_path(conn, :index))
  end
end
