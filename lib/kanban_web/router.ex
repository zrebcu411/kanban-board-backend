defmodule KanbanWeb.Router do
  use KanbanWeb, :router

  pipeline :graphql do
    plug(KanbanWeb.Context)
  end

  scope "/" do
    pipe_through(:graphql)

    post("/graphql", Absinthe.Plug, schema: KanbanWeb.Schema)

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: KanbanWeb.Schema,
      interface: :simple,
      context: %{pubsub: KanbanWeb.Endpoint}
    )
  end
end
