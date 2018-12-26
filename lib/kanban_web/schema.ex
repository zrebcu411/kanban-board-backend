defmodule KanbanWeb.Schema do
  use Absinthe.Schema

  import_types(KanbanWeb.Schema.AccountTypes)

  alias KanbanWeb.Resolvers
  alias KanbanWeb.Middlewares

  # def middleware(middleware, _field, %{identifier: :mutation}) do
  #   middleware ++ [MyApp.Middlewares.HandleChangesetErrors]
  # end

  # def middleware(middleware, _field, _object), do: middleware

  query(name: "Query") do
    field(:users, list_of(non_null(:user))) do
      resolve(&Resolvers.Accounts.all_users/3)
    end
  end

  mutation(name: "Mutation") do
    field :signup, non_null(:sign_up_response) do
      arg(:email, non_null(:string))
      arg(:name, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Accounts.sign_up/3)

      middleware(Middlewares.ChangesetErrors)
    end

    field :signin, non_null(:sign_in_response) do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Accounts.sign_in/3)
    end
  end
end
