defmodule DiscussWeb.PageController do
  use DiscussWeb, :controller

  def index(conn, params) do
    render(conn, "index.html")
  end
end
