defmodule Kanban.Boards.Card do
  use Ecto.Schema
  use Kanban.Schema
  import Ecto.Changeset

  schema "cards" do
    field(:title, :string)
    field(:description, :string)

    belongs_to(:lane, Kanban.Boards.Lane)

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:title, :description, :lane_id])
    |> validate_required([:title, :description, :lane_id])
    |> assoc_constraint(:lane)
  end
end
