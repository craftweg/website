defmodule PepicrftWeb.ProjectsController do
  use PepicrftWeb, :controller

  def index(conn, _params) do
    conn |> render(:index)
  end
end
