defmodule KanbanWeb.Schema.BoardTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 3]

  object :board do
    field(:id, non_null(:id))
    field(:title, non_null(:string))
    field(:color, non_null(:string))
    field(:private, non_null(:boolean))

    field(:lanes, non_null(list_of(non_null(:lane)))) do
      resolve(dataloader(Kanban.Boards, :lanes, args: %{resource: :lane}))
    end
  end

  object :lane do
    field(:id, non_null(:id))
    field(:title, non_null(:string))
  end
end
