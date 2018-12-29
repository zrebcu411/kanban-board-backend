defmodule KanbanWeb.Resolvers.Boards do
  alias Kanban.Boards

  def boards(_, _, info) do
    {:ok, Boards.list_user_boards(info.context.current_user.id)}
  end

  def create_board(_, args, info) do
    info.context.current_user
    |> Ecto.build_assoc(:boards, args)
    |> Map.from_struct()
    |> Boards.create_board()
  end

  def create_lane(_, args, info) do
    user_id = info.context.current_user.id
    board = Boards.get_user_board(args.board_id, user_id)

    case board do
      nil -> {:error, "User or board does not exist"}
      _ -> Boards.create_lane(args)
    end
  end
end
