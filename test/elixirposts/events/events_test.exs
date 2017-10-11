defmodule Elixirposts.EventsTest do
  use Elixirposts.DataCase

  alias Elixirposts.Events

  describe "conference" do
    alias Elixirposts.Events.Conferences

    @valid_attrs %{country: "some country", end_date: ~D[2010-04-17], fixed_date: ~D[2010-04-17], location: "some location", start_date: ~D[2010-04-17], title: "some title", year: 42}
    @update_attrs %{country: "some updated country", end_date: ~D[2011-05-18], fixed_date: ~D[2011-05-18], location: "some updated location", start_date: ~D[2011-05-18], title: "some updated title", year: 43}
    @invalid_attrs %{country: nil, end_date: nil, fixed_date: nil, location: nil, start_date: nil, title: nil, year: nil}

    def conferences_fixture(attrs \\ %{}) do
      {:ok, conferences} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_conferences()

      conferences
    end

    test "list_conference/0 returns all conference" do
      conferences = conferences_fixture()
      assert Events.list_conference() == [conferences]
    end

    test "get_conferences!/1 returns the conferences with given id" do
      conferences = conferences_fixture()
      assert Events.get_conferences!(conferences.id) == conferences
    end

    test "create_conferences/1 with valid data creates a conferences" do
      assert {:ok, %Conferences{} = conferences} = Events.create_conferences(@valid_attrs)
      assert conferences.country == "some country"
      assert conferences.end_date == ~D[2010-04-17]
      assert conferences.fixed_date == ~D[2010-04-17]
      assert conferences.location == "some location"
      assert conferences.start_date == ~D[2010-04-17]
      assert conferences.title == "some title"
      assert conferences.year == 42
    end

    test "create_conferences/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_conferences(@invalid_attrs)
    end

    test "update_conferences/2 with valid data updates the conferences" do
      conferences = conferences_fixture()
      assert {:ok, conferences} = Events.update_conferences(conferences, @update_attrs)
      assert %Conferences{} = conferences
      assert conferences.country == "some updated country"
      assert conferences.end_date == ~D[2011-05-18]
      assert conferences.fixed_date == ~D[2011-05-18]
      assert conferences.location == "some updated location"
      assert conferences.start_date == ~D[2011-05-18]
      assert conferences.title == "some updated title"
      assert conferences.year == 43
    end

    test "update_conferences/2 with invalid data returns error changeset" do
      conferences = conferences_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_conferences(conferences, @invalid_attrs)
      assert conferences == Events.get_conferences!(conferences.id)
    end

    test "delete_conferences/1 deletes the conferences" do
      conferences = conferences_fixture()
      assert {:ok, %Conferences{}} = Events.delete_conferences(conferences)
      assert_raise Ecto.NoResultsError, fn -> Events.get_conferences!(conferences.id) end
    end

    test "change_conferences/1 returns a conferences changeset" do
      conferences = conferences_fixture()
      assert %Ecto.Changeset{} = Events.change_conferences(conferences)
    end
  end
end
