defmodule ElixirpostsWeb.TalkController do
  use ElixirpostsWeb, :controller

  alias Elixirposts.Events
  alias Elixirposts.Events.Talk

  def index(conn, _params, conference) do
    IO.inspect conference
    talks = Events.list_talks(conference)
    render(conn, "index.html", talks: talks, conference: conference)
  end

  def new(conn, _params, conference) do
    changeset = Events.change_talk(%Talk{})
    render(conn, "new.html", changeset: changeset, conference: conference)
  end

  def create(conn, %{"talk" => talk_params}, conference) do
    case Events.create_talk(talk_params, conference) do
      {:ok, talk} ->
        conn
        |> put_flash(:info, "Talk created successfully.")
        |> redirect(to: conferences_talk_path(conn, :show, conference, talk))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, conference: conference)
    end
  end

  def show(conn, %{"id" => id}, conference) do
    talk = Events.get_talk!(id)
    render(conn, "show.html", talk: talk, conference: conference)
  end

  def edit(conn, %{"id" => id}, conference) do
    talk = Events.get_talk!(id)
    changeset = Events.change_talk(talk)
    render(conn, "edit.html", talk: talk, changeset: changeset, conference: conference)
  end

  def update(conn, %{"id" => id, "talk" => talk_params}, conference) do
    talk = Events.get_talk!(id)

    case Events.update_talk(talk, talk_params) do
      {:ok, talk} ->
        conn
        |> put_flash(:info, "Talk updated successfully.")
        |> redirect(to: conferences_talk_path(conn, :show, conference, talk))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", talk: talk, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, conference) do
    talk = Events.get_talk!(id)
    {:ok, _talk} = Events.delete_talk(talk)

    conn
    |> put_flash(:info, "Talk deleted successfully.")
    |> redirect(to: conferences_talk_path(conn, :index, conference))
  end

  def action(%{params: %{"conferences_id" => conference_id}} = conn, _) do
    conference = Events.get_conferences!(conference_id)
    apply(__MODULE__, action_name(conn),
    [conn, conn.params, conference])
  end
end
