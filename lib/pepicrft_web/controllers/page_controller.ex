defmodule PepicrftWeb.PageController do
  use PepicrftWeb, :controller

  def show(conn, _params) do
    path = conn.request_path
    page = Pepicrft.Pages.all_pages() |> Enum.find(&(&1.slug == path))
    render(conn, :show, %{page: page})
  end
end
