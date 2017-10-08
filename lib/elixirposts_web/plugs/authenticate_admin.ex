defmodule ElixirpostsWeb.Plugs.AuthenticateAdmin do
  import Phoenix.Controller
  alias ElixirpostsWeb.Router.Helpers, as: Routes

  def init(_params) do

  end

  def call(conn, _params) do
    if conn.assigns.admin do
      conn
    else
      conn
      |> put_flash(:error, "Unauthorized")
      |> redirect(to: Routes.session_path(conn, :new))
    end
  end
end
