defmodule Kanban.Boards.Board do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boards" do
    field(:color, :string)
    field(:private, :boolean, default: false)
    field(:title, :string)

    belongs_to(:user, Kanban.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title, :color, :private, :user_id])
    |> validate_required([:title, :color, :private, :user_id])
    |> assoc_constraint(:user)
  end
end