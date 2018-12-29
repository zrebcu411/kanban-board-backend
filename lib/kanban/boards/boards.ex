defmodule Kanban.Boards do
  @moduledoc """
  The Boards context.
  """

  import Ecto.Query, warn: false
  alias Kanban.Repo

  alias Kanban.Boards.Board

  @doc """
  Returns the list of boards.

  ## Examples

      iex> list_boards()
      [%Board{}, ...]

  """
  def list_boards do
    Repo.all(Board)
  end

  def list_user_boards(user_id) do
    Board |> Ecto.Query.where(user_id: ^user_id) |> Repo.all()
  end

  def get_user_board(id, user_id) do
    Board |> Repo.get_by(id: id, user_id: user_id)
  end

  @doc """
  Gets a single board.

  Raises `Ecto.NoResultsError` if the Board does not exist.

  ## Examples

      iex> get_board!(123)
      %Board{}

      iex> get_board!(456)
      ** (Ecto.NoResultsError)

  """
  def get_board!(id), do: Repo.get!(Board, id)

  @doc """
  Creates a board.

  ## Examples

      iex> create_board(%{field: value})
      {:ok, %Board{}}

      iex> create_board(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_board(attrs \\ %{}) do
    %Board{}
    |> Board.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a board.

  ## Examples

      iex> update_board(board, %{field: new_value})
      {:ok, %Board{}}

      iex> update_board(board, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_board(%Board{} = board, attrs) do
    board
    |> Board.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Board.

  ## Examples

      iex> delete_board(board)
      {:ok, %Board{}}

      iex> delete_board(board)
      {:error, %Ecto.Changeset{}}

  """
  def delete_board(%Board{} = board) do
    Repo.delete(board)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking board changes.

  ## Examples

      iex> change_board(board)
      %Ecto.Changeset{source: %Board{}}

  """
  def change_board(%Board{} = board) do
    Board.changeset(board, %{})
  end

  alias Kanban.Boards.Lane

  @doc """
  Returns the list of lanes.

  ## Examples

      iex> list_lanes()
      [%Lane{}, ...]

  """
  def list_lanes do
    Repo.all(Lane)
  end

  @doc """
  Gets a single lane.

  Raises `Ecto.NoResultsError` if the Lane does not exist.

  ## Examples

      iex> get_lane!(123)
      %Lane{}

      iex> get_lane!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lane!(id), do: Repo.get!(Lane, id)

  @doc """
  Creates a lane.

  ## Examples

      iex> create_lane(%{field: value})
      {:ok, %Lane{}}

      iex> create_lane(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lane(attrs \\ %{}) do
    %Lane{}
    |> Lane.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lane.

  ## Examples

      iex> update_lane(lane, %{field: new_value})
      {:ok, %Lane{}}

      iex> update_lane(lane, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lane(%Lane{} = lane, attrs) do
    lane
    |> Lane.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Lane.

  ## Examples

      iex> delete_lane(lane)
      {:ok, %Lane{}}

      iex> delete_lane(lane)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lane(%Lane{} = lane) do
    Repo.delete(lane)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lane changes.

  ## Examples

      iex> change_lane(lane)
      %Ecto.Changeset{source: %Lane{}}

  """
  def change_lane(%Lane{} = lane) do
    Lane.changeset(lane, %{})
  end
end
