defmodule ElixirpostsWeb.Router do
  use ElixirpostsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug :put_layout, {ElixirpostsWeb.LayoutView, "basic.html"}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirpostsWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    post "/search", PageController, :search
    get "/:subtopic", PageController, :list_subtopics
  end

  scope "/admin", ElixirpostsWeb do
    pipe_through :browser

    get "/new", SessionController, :new
    post "/new", SessionController, :create

    scope "/" do
      pipe_through :admin
      resources "/posts", PostController
    end

  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirpostsWeb do
  #   pipe_through :api
  # end
end
