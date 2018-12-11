defmodule KanbanWeb.Router do
  use KanbanWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", KanbanWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/" do
    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: KanbanWeb.Schema,
      interface: :simple,
      context: %{pubsub: KanbanWeb.Endpoint}
    )
  end

  # Other scopes may use custom stacks.
  # scope "/api", KanbanWeb do
  #   pipe_through :api
  # end
end
