defmodule KanbanWeb.Schema.BoardTypes do
  use Absinthe.Schema.Notation

  object :board do
    field(:id, non_null(:id))
    field(:title, non_null(:string))
    field(:color, non_null(:string))
    field(:private, non_null(:boolean))
  end

  object :lane do
    field(:id, non_null(:id))
    field(:title, non_null(:string))
  end
end
