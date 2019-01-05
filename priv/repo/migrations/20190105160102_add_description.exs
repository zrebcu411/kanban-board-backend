defmodule Kanban.Repo.Migrations.AddDescription do
  use Ecto.Migration

  def change do
    alter table(:boards) do
      add(:description, :string)
    end

    alter table(:cards) do
      add(:description, :string)
    end
  end
end
