defmodule ElixirpostsWeb.ConferencesControllerTest do
  use ElixirpostsWeb.ConnCase

  alias Elixirposts.Events

  @create_attrs %{country: "some country", end_date: ~D[2010-04-17], fixed_date: ~D[2010-04-17], location: "some location", start_date: ~D[2010-04-17], title: "some title", year: 42}
  @update_attrs %{country: "some updated country", end_date: ~D[2011-05-18], fixed_date: ~D[2011-05-18], location: "some updated location", start_date: ~D[2011-05-18], title: "some updated title", year: 43}
  @invalid_attrs %{country: nil, end_date: nil, fixed_date: nil, location: nil, start_date: nil, title: nil, year: nil}

  def fixture(:conferences) do
    {:ok, conferences} = Events.create_conferences(@create_attrs)
    conferences
  end

  describe "index" do
    test "lists all conference", %{conn: conn} do
      conn = get conn, conferences_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Conference"
    end
  end

  describe "new conferences" do
    test "renders form", %{conn: conn} do
      conn = get conn, conferences_path(conn, :new)
      assert html_response(conn, 200) =~ "New Conferences"
    end
  end

  describe "create conferences" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, conferences_path(conn, :create), conferences: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == conferences_path(conn, :show, id)

      conn = get conn, conferences_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Conferences"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, conferences_path(conn, :create), conferences: @invalid_attrs
      assert html_response(conn, 200) =~ "New Conferences"
    end
  end

  describe "edit conferences" do
    setup [:create_conferences]

    test "renders form for editing chosen conferences", %{conn: conn, conferences: conferences} do
      conn = get conn, conferences_path(conn, :edit, conferences)
      assert html_response(conn, 200) =~ "Edit Conferences"
    end
  end

  describe "update conferences" do
    setup [:create_conferences]

    test "redirects when data is valid", %{conn: conn, conferences: conferences} do
      conn = put conn, conferences_path(conn, :update, conferences), conferences: @update_attrs
      assert redirected_to(conn) == conferences_path(conn, :show, conferences)

      conn = get conn, conferences_path(conn, :show, conferences)
      assert html_response(conn, 200) =~ "some updated country"
    end

    test "renders errors when data is invalid", %{conn: conn, conferences: conferences} do
      conn = put conn, conferences_path(conn, :update, conferences), conferences: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Conferences"
    end
  end

  describe "delete conferences" do
    setup [:create_conferences]

    test "deletes chosen conferences", %{conn: conn, conferences: conferences} do
      conn = delete conn, conferences_path(conn, :delete, conferences)
      assert redirected_to(conn) == conferences_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, conferences_path(conn, :show, conferences)
      end
    end
  end

  defp create_conferences(_) do
    conferences = fixture(:conferences)
    {:ok, conferences: conferences}
  end
end
