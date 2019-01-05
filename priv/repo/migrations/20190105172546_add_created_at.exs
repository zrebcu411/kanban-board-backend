defmodule Kanban.Repo.Migrations.AddCreatedAt do
  use Ecto.Migration

  def change do
    rename(table(:users), :inserted_at, to: :created_at)
    rename(table(:boards), :inserted_at, to: :created_at)
    rename(table(:lanes), :inserted_at, to: :created_at)
    rename(table(:cards), :inserted_at, to: :created_at)
  end
end
