defmodule CraftwegWeb.PageController do
  use CraftwegWeb, :controller

  def home(conn, _params) do
    render(conn, "home.html")
  end

  def blog(conn, _params) do
    render(conn, "blog.html")
  end

  def blog_post(conn, %{"year" => year, "month" => month, "day" => day, "title" => title}) do
    slug = "/blog/#{year}/#{month}/#{day}/#{title}"
    post = Craftweg.Blog.all_posts() |> Enum.find(&(&1.slug == slug))
    render(conn, "post.html", %{post: post})
  end

  def feed(conn, _) do
    conn
    |> put_resp_content_type("text/xml")
    |> render("feed.xml")
  end


  def show(conn, _params) do
    path = conn.request_path
    page = Craftweg.Pages.all_pages() |> Enum.find(&(&1.slug == path))
    render(conn, "markdown.html", %{page: page})
  end
end
