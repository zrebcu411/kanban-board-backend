defmodule Kanban.Repo.Migrations.CreateLanes do
  use Ecto.Migration

  def change do
    create table(:lanes) do
      add(:title, :string)
      add(:board_id, references(:boards, on_delete: :nothing))

      timestamps()
    end

    create(index(:lanes, [:board_id]))
  end
end
