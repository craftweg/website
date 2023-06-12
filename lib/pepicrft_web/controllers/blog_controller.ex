defmodule PepicrftWeb.BlogController do
  use PepicrftWeb, :controller

  def index(conn, _params) do
    conn |> render(:index)
  end

  def show(conn, %{"year" => year, "month" => month, "day" => day, "title" => title}) do
    slug = "/blog/#{year}/#{month}/#{day}/#{title}"
    post = Pepicrft.Blog.all_posts() |> Enum.find(&(&1.slug == slug))
    render(conn, :show, %{post: post})
  end

  def feed(conn, _) do
    conn
    |> put_resp_content_type("text/xml")
    |> render("feed.xml",  layout: false)
  end
end
