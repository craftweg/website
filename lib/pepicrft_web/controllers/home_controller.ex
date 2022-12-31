defmodule PepicrftWeb.HomeController do
  use PepicrftWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
