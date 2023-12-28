defmodule PepicrftWeb.BlogController do
  use PepicrftWeb, :controller

  def show(conn, %{"year" => year, "month" => month, "day" => day, "title" => title}) do
    slug = "/blog/#{year}/#{month}/#{day}/#{title}"
    post = Pepicrft.Blog.all_posts() |> Enum.find(&(&1.slug == slug))
    conn = conn |> assign(:published_time, post.date)
    render(conn, :show, %{post: post})
  end
end
