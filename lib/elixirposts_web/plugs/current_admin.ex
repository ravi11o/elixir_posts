defmodule ElixirpostsWeb.Plugs.CurrentAdmin do
  import Plug.Conn
  alias Elixirposts.Accounts
  
  def init(_params) do

  end

  def call(conn, _params) do
    admin_id  = get_session(conn, :admin_id)

    cond do
      admin = admin_id && Accounts.get_admin(admin_id) ->
        conn
        |> assign(:admin, admin)
      true ->
        conn
        |> assign(:admin, nil)
    end
  end
end
