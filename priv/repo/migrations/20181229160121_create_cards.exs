defmodule Kanban.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :title, :string
      add :lane_id, references(:lanes, on_delete: :nothing)

      timestamps()
    end

    create index(:cards, [:lane_id])
  end
end
