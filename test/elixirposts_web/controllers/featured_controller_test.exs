defmodule ElixirpostsWeb.FeaturedControllerTest do
  use ElixirpostsWeb.ConnCase

  alias Elixirposts.Index

  @create_attrs %{description: "some description", official_url: "some official_url", packages: [], tags: [], title: "some title", url: "some url", writer: "some writer"}
  @update_attrs %{description: "some updated description", official_url: "some updated official_url", packages: [], tags: [], title: "some updated title", url: "some updated url", writer: "some updated writer"}
  @invalid_attrs %{description: nil, official_url: nil, packages: nil, tags: nil, title: nil, url: nil, writer: nil}

  def fixture(:featured) do
    {:ok, featured} = Index.create_featured(@create_attrs)
    featured
  end

  describe "index" do
    test "lists all featured", %{conn: conn} do
      conn = get conn, featured_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Featured"
    end
  end

  describe "new featured" do
    test "renders form", %{conn: conn} do
      conn = get conn, featured_path(conn, :new)
      assert html_response(conn, 200) =~ "New Featured"
    end
  end

  describe "create featured" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, featured_path(conn, :create), featured: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == featured_path(conn, :show, id)

      conn = get conn, featured_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Featured"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, featured_path(conn, :create), featured: @invalid_attrs
      assert html_response(conn, 200) =~ "New Featured"
    end
  end

  describe "edit featured" do
    setup [:create_featured]

    test "renders form for editing chosen featured", %{conn: conn, featured: featured} do
      conn = get conn, featured_path(conn, :edit, featured)
      assert html_response(conn, 200) =~ "Edit Featured"
    end
  end

  describe "update featured" do
    setup [:create_featured]

    test "redirects when data is valid", %{conn: conn, featured: featured} do
      conn = put conn, featured_path(conn, :update, featured), featured: @update_attrs
      assert redirected_to(conn) == featured_path(conn, :show, featured)

      conn = get conn, featured_path(conn, :show, featured)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, featured: featured} do
      conn = put conn, featured_path(conn, :update, featured), featured: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Featured"
    end
  end

  describe "delete featured" do
    setup [:create_featured]

    test "deletes chosen featured", %{conn: conn, featured: featured} do
      conn = delete conn, featured_path(conn, :delete, featured)
      assert redirected_to(conn) == featured_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, featured_path(conn, :show, featured)
      end
    end
  end

  defp create_featured(_) do
    featured = fixture(:featured)
    {:ok, featured: featured}
  end
end
