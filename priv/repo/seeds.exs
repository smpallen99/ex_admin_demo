# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ExAdminDemo.Repo.insert!(%ExAdminDemo.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ExAdminDemo.Product
alias ExAdminDemo.User
alias ExAdminDemo.Repo
require Logger

Repo.delete_all User
Repo.insert!(%User{username: "admin", email: "admin@example.com"})

    # field :title, :string
    # field :description, :string
    # field :author, :string
    # field :price, :decimal
    # field :featured, :boolean, default: false
    # field :available_on, Ecto.Date
    # field :image_file_name, :string

products = [
  ["Programming Phoenix Productive |> Reliable |> Fast", "Don’t accept the compromise between fast and beautiful: you can have it all. Phoenix creator Chris McCord, Elixir creator José Valim, and award-winning author Bruce Tate walk you through building an application that’s fast and reliable. At every step, you’ll learn from the Phoenix creators not just what to do, but why. Packed with insider insights, this definitive guide will be your constant companion in your journey from Phoenix novice to expert, as you build the next generation of web applications.",
   "Chris McCord, Bruce Tate, and José Valim", Decimal.new(23.00), true, Ecto.Date.cast!("2016-03-17"), ""],
  ["Programming Elixir: Functional |> Concurrent |> Pragmatic |> Fun", "You want to explore functional programming, but are put off by the academic feel (tell me about monads just one more time). You know you need concurrent applications, but also know these are almost impossible to get right. Meet Elixir, a functional, concurrent language built on the rock-solid Erlang VM. Elixir’s pragmatic syntax and built-in support for metaprogramming will make you productive and keep you interested for the long haul. This book is the introduction to Elixir for experienced programmers.", 
   "Dave Thomas", Decimal.new(48.00), true, Ecto.Date.cast!("2016-01-01"), ""], 
  ["Metaprogramming Elixir", "Write code that writes code with Elixir macros. Macros make metaprogramming possible and define the language itself. In this book, you’ll learn how to use macros to extend the language with fast, maintainable code and share functionality in ways you never thought possible. You’ll discover how to extend Elixir with your own first-class features, optimize performance, and create domain-specific languages.",
   "Chris McCord", Decimal.new(27.00), true, Ecto.Date.cast!("2016-02-14"), ""]
] 
Repo.delete_all Product
for p <- products do
  list = [:title, :description, :author, :price, :featured, :available_on, :image_file_name]
  |> Enum.zip(p)

  struct(%Product{}, list)
  |> Repo.insert!
end

