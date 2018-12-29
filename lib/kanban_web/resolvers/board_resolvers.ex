defmodule KanbanWeb.Resolvers.Boards do
  alias Kanban.Boards

  def board(_, args, info) do
    user_id = info.context.current_user.id
    board = Boards.get_user_board(args.id, user_id)

    case board do
      nil -> {:error, "User or board does not exist"}
      _ -> {:ok, board}
    end
  end

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

  def create_card(_, args, info) do
    user_id = info.context.current_user.id
    board_with_lane = Boards.get_user_lane(args.lane_id, args.board_id, user_id)

    case board_with_lane do
      nil -> {:error, "User, board or lane does not exist"}
      _ -> Boards.create_card(args)
    end
  end
end
