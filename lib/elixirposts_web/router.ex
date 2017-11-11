defmodule ElixirpostsWeb.Router do
  use ElixirpostsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ElixirpostsWeb.Plugs.CurrentAdmin
  end

  pipeline :admin do
    plug :put_layout, {ElixirpostsWeb.LayoutView, "basic.html"}
    plug ElixirpostsWeb.Plugs.AuthenticateAdmin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirpostsWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/conferences", PageController, :conference
    get "/conferences/:id/talks", PageController, :talks
    get "/conferences/:year", PageController, :conference_list


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
      resources "/conference", ConferencesController do
        resources "/talks", TalkController
      end
    end

  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirpostsWeb do
  #   pipe_through :api
  # end
end
