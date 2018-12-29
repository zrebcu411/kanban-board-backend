defmodule Kanban.BoardsTest do
  use Kanban.DataCase

  alias Kanban.Boards

  describe "boards" do
    alias Kanban.Boards.Board

    @valid_attrs %{color: "some color", private: true, title: "some title"}
    @update_attrs %{color: "some updated color", private: false, title: "some updated title"}
    @invalid_attrs %{color: nil, private: nil, title: nil}

    def board_fixture(attrs \\ %{}) do
      {:ok, board} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Boards.create_board()

      board
    end

    test "list_boards/0 returns all boards" do
      board = board_fixture()
      assert Boards.list_boards() == [board]
    end

    test "get_board!/1 returns the board with given id" do
      board = board_fixture()
      assert Boards.get_board!(board.id) == board
    end

    test "create_board/1 with valid data creates a board" do
      assert {:ok, %Board{} = board} = Boards.create_board(@valid_attrs)
      assert board.color == "some color"
      assert board.private == true
      assert board.title == "some title"
    end

    test "create_board/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Boards.create_board(@invalid_attrs)
    end

    test "update_board/2 with valid data updates the board" do
      board = board_fixture()
      assert {:ok, board} = Boards.update_board(board, @update_attrs)
      assert %Board{} = board
      assert board.color == "some updated color"
      assert board.private == false
      assert board.title == "some updated title"
    end

    test "update_board/2 with invalid data returns error changeset" do
      board = board_fixture()
      assert {:error, %Ecto.Changeset{}} = Boards.update_board(board, @invalid_attrs)
      assert board == Boards.get_board!(board.id)
    end

    test "delete_board/1 deletes the board" do
      board = board_fixture()
      assert {:ok, %Board{}} = Boards.delete_board(board)
      assert_raise Ecto.NoResultsError, fn -> Boards.get_board!(board.id) end
    end

    test "change_board/1 returns a board changeset" do
      board = board_fixture()
      assert %Ecto.Changeset{} = Boards.change_board(board)
    end
  end

  describe "lanes" do
    alias Kanban.Boards.Lane

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def lane_fixture(attrs \\ %{}) do
      {:ok, lane} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Boards.create_lane()

      lane
    end

    test "list_lanes/0 returns all lanes" do
      lane = lane_fixture()
      assert Boards.list_lanes() == [lane]
    end

    test "get_lane!/1 returns the lane with given id" do
      lane = lane_fixture()
      assert Boards.get_lane!(lane.id) == lane
    end

    test "create_lane/1 with valid data creates a lane" do
      assert {:ok, %Lane{} = lane} = Boards.create_lane(@valid_attrs)
      assert lane.title == "some title"
    end

    test "create_lane/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Boards.create_lane(@invalid_attrs)
    end

    test "update_lane/2 with valid data updates the lane" do
      lane = lane_fixture()
      assert {:ok, lane} = Boards.update_lane(lane, @update_attrs)
      assert %Lane{} = lane
      assert lane.title == "some updated title"
    end

    test "update_lane/2 with invalid data returns error changeset" do
      lane = lane_fixture()
      assert {:error, %Ecto.Changeset{}} = Boards.update_lane(lane, @invalid_attrs)
      assert lane == Boards.get_lane!(lane.id)
    end

    test "delete_lane/1 deletes the lane" do
      lane = lane_fixture()
      assert {:ok, %Lane{}} = Boards.delete_lane(lane)
      assert_raise Ecto.NoResultsError, fn -> Boards.get_lane!(lane.id) end
    end

    test "change_lane/1 returns a lane changeset" do
      lane = lane_fixture()
      assert %Ecto.Changeset{} = Boards.change_lane(lane)
    end
  end
end
