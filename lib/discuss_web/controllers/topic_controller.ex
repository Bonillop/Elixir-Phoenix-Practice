defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  def new(conn, _params) do
    IO.inspect(conn)
    IO.puts "pepe"
  end
end
