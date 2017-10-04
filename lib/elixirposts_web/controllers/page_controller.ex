defmodule ElixirpostsWeb.PageController do
  use ElixirpostsWeb, :controller

  alias Elixirposts.Index

  def index(conn, _params) do
    featured = Index.list_featured

    conn
    |> render("index.html", featured: featured) 
  end
end
