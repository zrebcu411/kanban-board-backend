defmodule Kanban.Boards.Board do
  use Ecto.Schema
  use Kanban.Schema
  import Ecto.Changeset

  schema "boards" do
    field(:color, :string)
    field(:private, :boolean, default: false)
    field(:title, :string)
    field(:description, :string)

    has_many(:lanes, Kanban.Boards.Board)

    belongs_to(:user, Kanban.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title, :description, :color, :private, :user_id])
    |> validate_required([:title, :description, :color, :private, :user_id])
    |> assoc_constraint(:user)
  end
end
