# Discuss

This is a practice phoenix app made following the course `The complete Elixir and Phoenix bootcamp` at udemy, still a work in progress

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

Next you need to define the routes in `router.ex` like so

>    get "/:provider", AuthController, :request # Function already defined by Euberauth \
\
>    get "/:provider/callback", AuthController, :callback # We also set this route in the provider's authorization callback url

then we define a `callback` function in our `auth_controller.ex`

inside the conn argument in the callback function we receive some information of the given user by the provider, for example the email, and an api token. We have to define what to do with this information, like registering the user to the database and save the token if the user has to consume more methods from the provider's api

## Controllers
Every controller function has two arguments `my_function(conn, params)` conn and params. conn represents the connection, which stores all the connection and request info, params on the other hand represents all the params that are sent to the request, for example an id

## Plugs
The simple way to understand a plug is that it is basically a middleware
There are two types of plugs, Module plugs and function plugs.

Module plugs are modules that import Plug.Conn, and have to define two functions, `init(_params)` and `call(conn, _params)`
the `params` argument in `call` is whatever return value comes from `init`
`init` defines an initialization that's optional
`call` defines the implementation logic of the plug everytime it is called

function plugs are just functions that define the implementation which would go in the `call` method of a module plug

plugs must return a connection or halt it and redirect

You can define pipelines with many plugs, example in router.ex
You can add guards to conditionally apply plugs, example in topic_controller.ex


# TODO
Set the client_id and client_secret for OAuth from environment variables