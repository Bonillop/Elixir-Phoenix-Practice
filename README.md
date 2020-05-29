# Discuss

To start your Phoenix server:

  * Setup the project with `mix setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Mix
https://hexdocs.pm/mix/Mix.html

Mix offers a lot of helpful commands to avoid quite a lot of boilerplate for many operations
running `mix help` will give you a good list with a concise description of what does each one of them do

`mix phx [command]` run specific commands for phoenix, those being creating a phoenix project or simply running the server

https://hexdocs.pm/phoenix/Phoenix.html

`mix ecto [command]` run specific commands of ecto, an Elixir library for interacting with a database, comes by default with a new phoenix project

https://hexdocs.pm/ecto/Ecto.html

## Notes
`.eex` stands for `embeded elixir`, this would be the default template engine so to speak.

https://hexdocs.pm/eex/EEx.html


## Euberauth / OAuth
Euberauth / OAuth is a library that lets you authenticate yourself using for example a facebook, google or github account on to another aplication.

In this app there's an example with github. So first and foremost you have to go to the developer settings in github, on your account, and register the app in order to get the client ID and client secret for later use with the authentication system