defmodule Elixirposts.Repo.Migrations.AddSearchesView do
  use Ecto.Migration

  def change do
    execute("
      CREATE VIEW searches AS

      SELECT
        posts.id AS searchable_id,
        'Post' AS searchable_type,
        posts.title as term
      FROM posts

      UNION

      SELECT
        posts.id AS searchable_id,
        'Post' AS searchable_type,
        posts.writer AS term
      FROM posts

      UNION

      SELECT
        posts.id AS searchable_id,
        'Post' AS searchable_type,
        posts.subtopic AS term
      FROM posts
    ")
  end
end
