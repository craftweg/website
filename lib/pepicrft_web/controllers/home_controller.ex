defmodule PepicrftWeb.HomeController do
  use PepicrftWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def about(conn, _params) do
    render(conn, :about)
  end
end
