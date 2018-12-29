defmodule Kanban.Boards.Lane do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lanes" do
    field(:title, :string)

    has_many(:cards, Kanban.Boards.Card)

    belongs_to(:board, Kanban.Boards.Board)

    timestamps()
  end

  @doc false
  def changeset(lane, attrs) do
    lane
    |> cast(attrs, [:title, :board_id])
    |> validate_required([:title, :board_id])
    |> assoc_constraint(:board)
  end
end
