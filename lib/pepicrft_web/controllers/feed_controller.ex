defmodule PepicrftWeb.FeedController do
  use PepicrftWeb, :controller

  def blog(conn, _) do
    %{title: title, description: description, language: language, base_url: base_url} =
      Application.fetch_env!(:pepicrft, :metadata)

    posts = Pepicrft.Blog.all_posts()
    last_build_date = posts |> List.first() |> Map.get(:date)

    conn
    |> put_resp_content_type("text/xml")
    |> render("blog.xml",
      layout: false,
      posts: posts,
      title: title,
      description: description,
      language: language,
      base_url: base_url,
      last_build_date: last_build_date
    )
  end
end
