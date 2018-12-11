defmodule KanbanWeb.Schema.AccountTypes do
  use Absinthe.Schema.Notation

  object :user do
    field(:id, non_null(:id))
    field(:email, non_null(:string))
    field(:name, non_null(:string))
    field(:password_hash, non_null(:string))
  end

  object :sign_up_result do
    field(:token, non_null(:string))
  end

  enum :sign_up_error do
    value(:user_does_not_exist)
    value(:password_invalid)
  end

  object :sign_up_response do
    field(:result, :sign_up_result) do
      resolve(&KanbanWeb.Resolvers.Accounts.sign_up_result/3)
    end

    field(:errors, non_null(list_of(non_null(:sign_up_error)))) do
      resolve(&KanbanWeb.Resolvers.Accounts.sign_up_errors/3)
    end
  end

  object :sign_in_result do
    field(:token, non_null(:string))
  end

  enum :sign_in_error do
    value(:user_does_not_exist)
    value(:password_invalid)
  end

  object :sign_in_response do
    field(:result, :sign_up_result) do
      resolve(&KanbanWeb.Resolvers.Accounts.sign_up_result/3)
    end

    field(:errors, non_null(list_of(non_null(:sign_in_error)))) do
      resolve(&KanbanWeb.Resolvers.Accounts.sign_in_errors/3)
    end
  end
end
