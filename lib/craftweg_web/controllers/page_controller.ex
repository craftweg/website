defmodule CraftwegWeb.PageController do
  use CraftwegWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
