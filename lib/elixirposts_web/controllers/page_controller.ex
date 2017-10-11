defmodule ElixirpostsWeb.PageController do
  use ElixirpostsWeb, :controller

  alias Elixirposts.{Index, Index.Post}

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
  end

  def conference_list(conn, _params) do
    conn
  end

  def talks(conn, _params) do
    conn
  end

  def search(conn, %{"search" => %{"search_input" => input}}) do
    posts = Post.search(input)
    conn
    |> render("index.html", featured: posts, page: nil)
  end
end
