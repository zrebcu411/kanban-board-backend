defmodule SignUpResult do
  defstruct token: ""
end

defmodule SignInResult do
  defstruct token: ""
end

defmodule Auth do
  alias Kanban.Repo
  alias Kanban.Accounts.User
  alias Comeonin.Bcrypt

  def authenticate_user(email, password) do
    user = Repo.get_by(User, email: String.downcase(email))

    case user do
      nil ->
        Bcrypt.dummy_checkpw()
        {:error, :user_does_not_exist}

      user ->
        if Bcrypt.checkpw(password, user.password_hash) do
          {:ok, user}
        else
          {:error, :password_invalid}
        end
    end
  end
end

defmodule KanbanWeb.Resolvers.Accounts do
  alias Kanban.Accounts

  def me(_, _, %{context: %{current_user: current_user}}) do
    case Kanban.Accounts.get_user(current_user.id) do
      nil -> {:ok, nil}
      user -> {:ok, user}
    end
  end

  def me(_, _, _) do
    {:ok, nil}
  end

  def sign_up(_, args, _) do
    with {:ok, user} <- Accounts.create_user(args),
         {:ok, token, _} <- Accounts.Guardian.encode_and_sign(user) do
      {:ok, %{token: token}}
    else
      error ->
        {:ok, error}
    end
  end

  def sign_up_errors({:error, %Ecto.Changeset{} = changeset}, _, _) do
    errors =
      changeset
      |> Ecto.Changeset.traverse_errors(fn {err, _opts} -> err end)
      |> Enum.flat_map(fn {_, err} -> err end)

    {:ok, errors}
  end

  def sign_up_errors(_, _, _) do
    {:ok, []}
  end

  def sign_up_result(%{token: token}, _, _) do
    {:ok, %SignUpResult{token: token}}
  end

  def sign_up_result(_, _, _) do
    {:ok, nil}
  end

  def sign_in(_, %{email: email, password: password}, _) do
    with {:ok, user} <- Auth.authenticate_user(email, password),
         {:ok, token, _} <- Accounts.Guardian.encode_and_sign(user) do
      {:ok, %{token: token}}
    else
      error -> {:ok, error}
    end
  end

  def sign_in_errors({:error, error}, _, _) do
    {:ok, [error]}
  end

  def sign_in_errors(_, _, _) do
    {:ok, []}
  end

  def sign_in_result(%{token: token}, _, _) do
    {:ok, %SignInResult{token: token}}
  end

  def sign_in_result(_, _, _) do
    {:ok, nil}
  end
end
