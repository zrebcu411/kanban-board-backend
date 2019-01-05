defmodule KanbanWeb.Context do
  @behaviour Plug

  import Plug.Conn

  alias Kanban.Accounts

  # alias Kanban.Boards

  # def dataloader() do
  #   Dataloader.new()
  #   |> Dataloader.add_source("22", Boards.data())
  # end

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user, _} <- Accounts.Guardian.resource_from_token(token) do
      %{current_user: user}
    else
      _ ->
        %{}
    end
  end
end
