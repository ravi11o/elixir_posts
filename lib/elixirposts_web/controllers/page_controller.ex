defmodule ElixirpostsWeb.PageController do
  use ElixirpostsWeb, :controller

  alias Elixirposts.{Index, Index.Post, Events}

  def index(conn, params) do
    page = Index.list_featured_with_page(params)
    conn
    |> render("index.html", featured: page.entries, page: page)
  end

  def list_subtopics(conn, params) do
    page = Index.get_subtopic_list(params)
     conn
     |> render("index.html", featured: page.entries, page: page)
  end

  def conference(conn, _params) do
    conn
    |> render("conference.html")
  end

  def conference_list(conn, %{"year" => year}) do
    list = Events.get_conferences_by_year(year)

    conn
    |> render("conference_list.html", list: list)
  end

  def talks(conn, %{"id" => id}) do
    talks = Events.talks_by_conference_id(id)

    conn
    |> render("talks.html", talks: talks)
  end

  def search(conn, %{"search" => %{"search_input" => input}}) do
    posts = Post.search(input)
    conn
    |> render("index.html", featured: posts, page: nil)
  end
end
