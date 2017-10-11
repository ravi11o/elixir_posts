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

  describe "talks" do
    alias Elixirposts.Events.Talk

    @valid_attrs %{creator: "some creator", tags: [], title: "some title", url: "some url", views: 42}
    @update_attrs %{creator: "some updated creator", tags: [], title: "some updated title", url: "some updated url", views: 43}
    @invalid_attrs %{creator: nil, tags: nil, title: nil, url: nil, views: nil}

    def talk_fixture(attrs \\ %{}) do
      {:ok, talk} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_talk()

      talk
    end

    test "list_talks/0 returns all talks" do
      talk = talk_fixture()
      assert Events.list_talks() == [talk]
    end

    test "get_talk!/1 returns the talk with given id" do
      talk = talk_fixture()
      assert Events.get_talk!(talk.id) == talk
    end

    test "create_talk/1 with valid data creates a talk" do
      assert {:ok, %Talk{} = talk} = Events.create_talk(@valid_attrs)
      assert talk.creator == "some creator"
      assert talk.tags == []
      assert talk.title == "some title"
      assert talk.url == "some url"
      assert talk.views == 42
    end

    test "create_talk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_talk(@invalid_attrs)
    end

    test "update_talk/2 with valid data updates the talk" do
      talk = talk_fixture()
      assert {:ok, talk} = Events.update_talk(talk, @update_attrs)
      assert %Talk{} = talk
      assert talk.creator == "some updated creator"
      assert talk.tags == []
      assert talk.title == "some updated title"
      assert talk.url == "some updated url"
      assert talk.views == 43
    end

    test "update_talk/2 with invalid data returns error changeset" do
      talk = talk_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_talk(talk, @invalid_attrs)
      assert talk == Events.get_talk!(talk.id)
    end

    test "delete_talk/1 deletes the talk" do
      talk = talk_fixture()
      assert {:ok, %Talk{}} = Events.delete_talk(talk)
      assert_raise Ecto.NoResultsError, fn -> Events.get_talk!(talk.id) end
    end

    test "change_talk/1 returns a talk changeset" do
      talk = talk_fixture()
      assert %Ecto.Changeset{} = Events.change_talk(talk)
    end
  end
end
