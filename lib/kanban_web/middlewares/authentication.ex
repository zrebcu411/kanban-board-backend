defmodule KanbanWeb.Middlewares.Authentication do
  @behaviour Absinthe.Middleware

  def call(resolution, _) do
    case resolution.context do
      %{current_user: _current_user} ->
        resolution

      _ ->
        Absinthe.Resolution.put_result(
          resolution,
          {:error, "Unauthorized"}
        )
    end
  end
end
