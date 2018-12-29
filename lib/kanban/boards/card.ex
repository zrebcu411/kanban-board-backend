defmodule Kanban.Boards.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field(:title, :string)

    belongs_to(:lane, Kanban.Boards.Lane)

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:title, :lane_id])
    |> validate_required([:title, :lane_id])
    |> assoc_constraint(:lane)
  end
end
