defmodule KanbanWeb.Schema do
  use Absinthe.Schema

  import_types(KanbanWeb.Schema.AccountTypes)
  import_types(KanbanWeb.Schema.BoardTypes)

  alias KanbanWeb.Resolvers
  alias KanbanWeb.Middlewares

  alias Kanban.Boards

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Boards, Boards.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query(name: "Query") do
    field(:me, :user) do
      middleware(Middlewares.Authentication)
      resolve(&Resolvers.Accounts.me/3)
    end

    field(:board, non_null(:board)) do
      arg(:id, non_null(:integer))
      middleware(Middlewares.Authentication)
      resolve(&Resolvers.Boards.board/3)
    end

    field(:boards, non_null(list_of(non_null(:board)))) do
      middleware(Middlewares.Authentication)
      resolve(&Resolvers.Boards.boards/3)
    end
  end

  mutation(name: "Mutation") do
    field :signup, non_null(:sign_up_response) do
      arg(:email, non_null(:string))
      arg(:name, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Accounts.sign_up/3)
    end

    field :signin, non_null(:sign_in_response) do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Accounts.sign_in/3)
    end

    field :create_board, non_null(:board) do
      arg(:title, non_null(:string))
      arg(:color, non_null(:string))
      arg(:private, non_null(:boolean))
      resolve(&Resolvers.Boards.create_board/3)
    end

    field :create_lane, non_null(:lane) do
      arg(:board_id, non_null(:integer))
      arg(:title, non_null(:string))
      resolve(&Resolvers.Boards.create_lane/3)
    end
  end
end
