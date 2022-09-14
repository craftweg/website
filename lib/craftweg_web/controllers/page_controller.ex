defmodule CraftwegWeb.PageController do
  use CraftwegWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, _params) do
    path = conn.request_path
    page = Craftweg.Pages.all_pages() |> Enum.find(&(&1.slug == path))
    render(conn, "markdown.html", %{page: page})
  end
end
