defmodule Elixirposts.IndexTest do
  use Elixirposts.DataCase

  alias Elixirposts.Index

  describe "featured" do
    alias Elixirposts.Index.Featured

    @valid_attrs %{description: "some description", official_url: "some official_url", packages: [], tags: [], title: "some title", url: "some url", writer: "some writer"}
    @update_attrs %{description: "some updated description", official_url: "some updated official_url", packages: [], tags: [], title: "some updated title", url: "some updated url", writer: "some updated writer"}
    @invalid_attrs %{description: nil, official_url: nil, packages: nil, tags: nil, title: nil, url: nil, writer: nil}

    def featured_fixture(attrs \\ %{}) do
      {:ok, featured} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Index.create_featured()

      featured
    end

    test "list_featured/0 returns all featured" do
      featured = featured_fixture()
      assert Index.list_featured() == [featured]
    end

    test "get_featured!/1 returns the featured with given id" do
      featured = featured_fixture()
      assert Index.get_featured!(featured.id) == featured
    end

    test "create_featured/1 with valid data creates a featured" do
      assert {:ok, %Featured{} = featured} = Index.create_featured(@valid_attrs)
      assert featured.description == "some description"
      assert featured.official_url == "some official_url"
      assert featured.packages == []
      assert featured.tags == []
      assert featured.title == "some title"
      assert featured.url == "some url"
      assert featured.writer == "some writer"
    end

    test "create_featured/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Index.create_featured(@invalid_attrs)
    end

    test "update_featured/2 with valid data updates the featured" do
      featured = featured_fixture()
      assert {:ok, featured} = Index.update_featured(featured, @update_attrs)
      assert %Featured{} = featured
      assert featured.description == "some updated description"
      assert featured.official_url == "some updated official_url"
      assert featured.packages == []
      assert featured.tags == []
      assert featured.title == "some updated title"
      assert featured.url == "some updated url"
      assert featured.writer == "some updated writer"
    end

    test "update_featured/2 with invalid data returns error changeset" do
      featured = featured_fixture()
      assert {:error, %Ecto.Changeset{}} = Index.update_featured(featured, @invalid_attrs)
      assert featured == Index.get_featured!(featured.id)
    end

    test "delete_featured/1 deletes the featured" do
      featured = featured_fixture()
      assert {:ok, %Featured{}} = Index.delete_featured(featured)
      assert_raise Ecto.NoResultsError, fn -> Index.get_featured!(featured.id) end
    end

    test "change_featured/1 returns a featured changeset" do
      featured = featured_fixture()
      assert %Ecto.Changeset{} = Index.change_featured(featured)
    end
  end
end
