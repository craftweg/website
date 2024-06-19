defmodule PepicrftWeb.HomeController do
  use PepicrftWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def about(conn, _params) do
    render(conn, :about)
  end

  def projects(conn, _params) do
    render(conn, :projects)
  end

  def mastodon(conn, _params) do
    %{body: statuses} = Req.get!("https://masto.pepicrft.me/api/v1/accounts/112545800553693985/statuses")
    render(conn, :mastodon, statuses: statuses)
  end

  def photos(conn, _params) do
    render(conn, :photos)
  end
end
