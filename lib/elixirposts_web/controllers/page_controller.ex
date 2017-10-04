defmodule ElixirpostsWeb.PageController do
  use ElixirpostsWeb, :controller

  alias Elixirposts.Index

  def index(conn, params) do
    page = Index.list_featured_with_page(params)

    conn
    |> render("index.html", featured: page.entries, page: page)
  end
end
