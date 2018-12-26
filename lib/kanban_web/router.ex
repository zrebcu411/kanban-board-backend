defmodule KanbanWeb.Router do
  use KanbanWeb, :router

  scope "/" do
    post("/graphql", Absinthe.Plug, schema: KanbanWeb.Schema)

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: KanbanWeb.Schema,
      interface: :simple,
      context: %{pubsub: KanbanWeb.Endpoint}
    )
  end
end
