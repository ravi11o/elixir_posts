defmodule ElixirpostsWeb.PageController do
  use ElixirpostsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
