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
alias ExAdminDemo.LineItem
alias ExAdminDemo.Order
alias Ecto.DateTime, as: Dt
import Ecto.Query

Faker.start

require Logger

Repo.delete_all LineItem
Repo.delete_all Order
Repo.delete_all Product
Repo.delete_all User

Repo.insert!(%User{username: "admin", email: "admin@example.com"})

    # field :title, :string
    # field :description, :string
    # field :author, :string
    # field :price, :decimal
    # field :featured, :boolean, default: false
    # field :available_on, Ecto.Date
    # field :image_file_name, :string

img = fn(fname) -> 
  %{
    file_name: fname, 
    updated_at: Ecto.DateTime.cast!("2016-03-17T00:05:01Z"), 
    inserted_at: Ecto.DateTime.cast!("2016-03-17T00:05:01Z")
  }
end

products = [
  ["Programming Phoenix Productive |> Reliable |> Fast", "Don’t accept the compromise between fast and beautiful: you can have it all. Phoenix creator Chris McCord, Elixir creator José Valim, and award-winning author Bruce Tate walk you through building an application that’s fast and reliable. At every step, you’ll learn from the Phoenix creators not just what to do, but why. Packed with insider insights, this definitive guide will be your constant companion in your journey from Phoenix novice to expert, as you build the next generation of web applications.",
   "Chris McCord, Bruce Tate, and José Valim", Decimal.new(23.00), true, Ecto.Date.cast!("2016-03-17"), img.("programming_phoenix.jpg")],
  ["Programming Elixir: Functional |> Concurrent |> Pragmatic |> Fun", "You want to explore functional programming, but are put off by the academic feel (tell me about monads just one more time). You know you need concurrent applications, but also know these are almost impossible to get right. Meet Elixir, a functional, concurrent language built on the rock-solid Erlang VM. Elixir’s pragmatic syntax and built-in support for metaprogramming will make you productive and keep you interested for the long haul. This book is the introduction to Elixir for experienced programmers.", 
   "Dave Thomas", Decimal.new(48.00), true, Ecto.Date.cast!("2016-01-01"), img.("programming_elixir.jpg")], 
  ["Metaprogramming Elixir", "Write code that writes code with Elixir macros. Macros make metaprogramming possible and define the language itself. In this book, you’ll learn how to use macros to extend the language with fast, maintainable code and share functionality in ways you never thought possible. You’ll discover how to extend Elixir with your own first-class features, optimize performance, and create domain-specific languages.",
   "Chris McCord", Decimal.new(27.00), true, Ecto.Date.cast!("2016-02-14"), img.("meta_programming_elixir.jpg")],
  ["Elixir in Action", "Elixir in Action teaches you to apply the new Elixir programming language to practical problems associated with scalability, concurrency, fault tolerance, and high availability.",
   "Saša Jurić", Decimal.new(40.07), false, Ecto.Date.cast!("2016-02-14"), img.("elixir_in_action.jpg")],
  ["Introducing Elixir: Getting Started in Functional Programming", "Elixir is an excellent language if you want to learn about functional programming, and with this hands-on introduction, you&#8217;ll discover just how powerful and fun Elixir can be. This language combines the robust functional programming of Erlang with a syntax similar to Ruby, and includes powerful features for metaprogramming.",
   " Simon St. Laurent,  J. David Eisenberg", Decimal.new(24.99), false, Ecto.Date.cast!("2016-02-15"), img.("introducting_elixir.jpg")],
  ["Learning Elixir", "Elixir, based on Erlang's virtual machine and ecosystem, makes it easier to achieve scalability, concurrency, fault tolerance, and high availability goals that are pursued by developers using any programming language or programming paradigm. Elixir is a modern programming language that utilizes the benefits offered by Erlang VM without really incorporating the complex syntaxes of Erlang.",
   " Kenny Ballou", Decimal.new(27.99), false, Ecto.Date.cast!("2016-02-18"), img.("learing_elixir.jpg")],
  ["Programming Erlang: Software for a Concurrent World (Pragmatic Programmers)", "A multi-user game, web site, cloud application, or networked database can have thousands of users all interacting at the same time. You need a powerful, industrial-strength tool to handle the really hard problems inherent in parallel, concurrent environments. You need Erlang. In this second edition of the bestselling Programming Erlang, you'll learn how to write parallel programs that scale effortlessly on multicore systems.",
   "Joe Armstrong", Decimal.new(39.18), true, Ecto.Date.cast!("2016-02-19"), img.("programming_erlang.jpg")],
  ["Designing for Scalability with Erlang/OTP: Implement Robust, Available, Fault-Tolerant Systems", "Design and build complex, scalable commercial-grade systems with the Open Telecom Platform (OTP), the open source system developed by Ericsson and written in Erlang. With this hands-on book, you’ll learn how to apply OTP libraries and techniques to develop concurrent, fault-tolerant systems with no single point of failure.",
   "Francesco Cesarini, Steve Vinoski", Decimal.new(37.49), false, Ecto.Date.cast!("2016-01-14"), img.("designing_for_scalability.jpg")],
  # ["Erlang Programming", "This book is an in-depth introduction to Erlang, a programming language ideal for any situation where concurrency, fault tolerance, and fast response is essential. Erlang is gaining widespread adoption with the advent of multi-core processors and their new scalable approach to concurrency. With this guide you'll learn how to write complex concurrent programs in Erlang, regardless of your programming background or experience.",
  #  "Francesco Cesarini, Simon Thompson", Decimal.new(39.70), false, Ecto.Date.cast!("2016-01-04"), nil],
  ["Learn You Some Erlang for Great Good!: A Beginner's Guide", "Erlang is the language of choice for programmers who want to write robust, concurrent applications, but its strange syntax and functional design can intimidate the uninitiated. Luckily, there's a new weapon in the battle against Erlang-phobia: Learn You Some Erlang for Great Good!",
   " Fred Hebert", Decimal.new(37.95), false, Ecto.Date.cast!("2016-03-14"), img.("learn_you_some_erlang.jpg")],
  ["Erlang and OTP in Action", "Concurrent programming has become a required discipline for all programmers. Multi-core processors and the increasing demand for maximum performance and scalability in mission-critical applications have renewed interest in functional languages like Erlang that are designed to handle concurrent programming. Erlang, and the OTP platform, make it possible to deliver more robust applications that satisfy rigorous uptime and performance requirements.",
   "Martin Logan, Eric Merritt, Richard Carlsson", Decimal.new(42.05), false, Ecto.Date.cast!("2016-04-04"), img.("erlang_and_otp_in_action.jpg")],
  ["Introducing Erlang: Getting Started in Functional Programming", "If you’re new to Erlang, its functional style can seem difficult, but with help from this hands-on introduction, you’ll scale the learning curve and discover how enjoyable, powerful, and fun this language can be.",
   "Simon St. Laurent", Decimal.new(19.99), false, Ecto.Date.cast!("2016-04-01"), img.("introducting_erlang.jpg")],
  ["Building Web Applications with Erlang: Working with REST and Web Sockets on Yaws", "Why choose Erlang for web applications? Discover the answer hands-on by building a simple web service with this book. If you’re an experienced web developer who knows basic Erlang, you’ll learn how to work with REST, dynamic content, web sockets, and concurrency through several examples. In the process, you’ll see first-hand that Erlang is ideal for building business-critical services.",
   "Zachary Kessin", Decimal.new(15.84), false, Ecto.Date.cast!("2015-02-14"), img.("building_web_apps.jpg")],
  ["Exercises for Programmers", "When you write software, you need to be at the top of your game. Great programmers practice to keep their skills sharp. Get sharp and stay sharp with more than fifty practice exercises rooted in real-world scenarios. If you’re a new programmer, these challenges will help you learn what you need to break into the field, and if you’re a seasoned pro, you can use these exercises to learn that hot new language for your next gig.",
   "Brian P. Hogan", Decimal.new(24.00), false, Ecto.Date.cast!("2015-01-17"), img.("exercises_for_programmers.jpg")],
  ["Seven More Languages in Seven Weeks", "Great programmers aren’t born—they’re made. The industry is moving from object-oriented languages to functional languages, and you need to commit to radical improvement. New programming languages arm you with the tools and idioms you need to refine your craft. While other language primers take you through basic installation and “Hello, World,” we aim higher. Each language in Seven More Languages in Seven Weeks will take you on a step-by-step journey through the most important paradigms of our time. You’ll learn seven exciting languages: Lua, Factor, Elixir, Elm, Julia, MiniKanren, and Idris.",
   "Bruce Tate, Fred Daoud, Jack Moffitt, Ian Dees", Decimal.new(38.00), false, Ecto.Date.cast!("2015-01-15"), img.("seven_more_languages.jpg")],
  ["Seven Web Frameworks in Seven Weeks", "Whether you need a new tool or just inspiration, Seven Web Frameworks in Seven Weeks explores modern options, giving you a taste of each with ideas that will help you create better apps. You’ll see frameworks that leverage modern programming languages, employ unique architectures, live client-side instead of server-side, or embrace type systems. You’ll see everything from familiar Ruby and JavaScript to the more exotic Erlang, Haskell, and Clojure.",
   "Jack Moffitt, Fred Daoud", Decimal.new(38.00), false, Ecto.Date.cast!("2016-02-14"), img.("seven_web_frameworks.jpg")],
  ["Seven Concurrency Models in Seven Weeks", "Your software needs to leverage multiple cores, handle thousands of users and terabytes of data, and continue working in the face of both hardware and software failure. Concurrency and parallelism are the keys, and Seven Concurrency Models in Seven Weeks equips you for this new world. See how emerging technologies such as actors and functional programming address issues with traditional threads and locks development. Learn how to exploit the parallelism in your computer’s GPU and leverage clusters of machines with MapReduce and Stream Processing. And do it all with the confidence that comes from using tools that help you write crystal clear, high-quality code.",
   "Paul Butcher", Decimal.new(38.00), false, Ecto.Date.cast!("2016-02-14"), img.("seven_concurrency.jpg")],
] 
Repo.delete_all Product
for p <- products do
  list = [:title, :description, :author, :price, :featured, :available_on, :image_file_name]
  |> Enum.zip(p)

  struct(%Product{}, list)
  |> Repo.insert!
end

nb_users = 100
for n <- 1..nb_users do
  %User{
    username: Faker.Internet.user_name <> Integer.to_string(n),
    email: Faker.Internet.email |> String.replace("@", "#{n}@"),
  }
  |> Repo.insert!
end

nb_orders = 300

users = Repo.all User
products = Repo.all Product

for _i <- 1..nb_orders do
  u = Enum.random users
  order = Repo.insert! %Order{user_id: u.id}

  nb_items = :rand.uniform(9) + 1
  for _i <- 1..nb_items do
    prod = Enum.random products
    Repo.insert! %LineItem{product_id: prod.id, order_id: order.id, price: prod.price}
  end

  id = order.id
  order = where(Order, [o], o.id == ^id) 
  |> preload([:line_items])
  |> Repo.one!

  Order.recalculate_price!(order)
  if :rand.uniform(100) < 90, do: Order.checkout!(order)
end
