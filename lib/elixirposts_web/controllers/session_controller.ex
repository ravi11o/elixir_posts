defmodule ElixirpostsWeb.SessionController do
  use ElixirpostsWeb, :controller
  alias Elixirposts.Accounts
  import Comeonin.Bcrypt

  plug :put_layout, "basic.html"

  def new(conn, _params) do
    conn
    |> render("new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    admin = Accounts.get_admin_by_email(email)
    IO.inspect admin
    result =
      cond do
        admin && checkpw(password, admin.hashed_password) ->
          {:ok, admin}
        admin ->
          {:error, "wrong password"}
        true -> {:error, "unauthorized"}
      end
    IO.inspect result
    case result do
      {:ok, admin} ->
        conn
        |> put_flash(:info, "login Successful")
        |> put_session(:admin_id, admin.id)
        |> redirect(to: post_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid Credentials")
        |> put_session(:admin_id, nil)
        |> redirect(to: session_path(conn, :new))
    end
  end
end
