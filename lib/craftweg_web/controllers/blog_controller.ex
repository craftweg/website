defmodule CraftwegWeb.BlogController do
  use CraftwegWeb, :controller

  def post(conn, %{"year" => year, "month" => month, "day" => day, "title" => title}) do
    slug = "/#{year}/#{month}/#{day}/#{title}"
    post = Craftweg.Blog.all_posts |> Enum.find(& &1.slug == slug)
    render(conn, "post.html", %{post: post})
  end
end
