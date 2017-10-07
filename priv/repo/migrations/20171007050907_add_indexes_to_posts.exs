defmodule Elixirposts.Repo.Migrations.AddIndexesToPosts do
  use Ecto.Migration

  def change do
    execute("CREATE INDEX index_posts_on_title ON posts USING gin(to_tsvector('english', title))")
    execute("CREATE INDEX index_posts_on_writer ON posts USING gin(to_tsvector('english', writer))")
    execute("CREATE INDEX index_posts_on_subtopic ON posts USING gin(to_tsvector('english', subtopic))")
  end
end
