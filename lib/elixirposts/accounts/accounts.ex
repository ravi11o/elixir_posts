defmodule Elixirposts.Accounts do

  alias Elixirposts.Repo
  alias Elixirposts.Accounts.Admin

  # Get Admin by email
  def get_admin_by_email(email) do
    Repo.get_by(Admin, email: email)
  end

end
