defmodule KanbanWeb.Schema do
  use Absinthe.Schema

  import_types(KanbanWeb.Schema.AccountTypes)
  import_types(KanbanWeb.Schema.BoardTypes)

  alias KanbanWeb.Resolvers
  alias KanbanWeb.Middlewares

  query(name: "Query") do
    field(:me, :user) do
      middleware(Middlewares.Authentication)
      resolve(&Resolvers.Accounts.me/3)
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
  end
end
