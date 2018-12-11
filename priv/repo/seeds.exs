# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Kanban.Repo.insert!(%Kanban.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Kanban.Accounts.User
alias Kanban.Repo

%User{email: "john.doe@gmail.com", name: "John Doe"} |> Repo.insert!()
%User{email: "emma.watson@op.pl", name: "Emma Watson"} |> Repo.insert!()
