defmodule PepicrftWeb.FeedController do
  use PepicrftWeb, :controller

  def blog(conn, _) do
    metadata = Application.fetch_env!(:pepicrft, :metadata)
    title = metadata |> Keyword.fetch!(:title)
    description = metadata |> Keyword.fetch!(:description)
    language = metadata |> Keyword.fetch!(:language)
    base_url = metadata |> Keyword.fetch!(:base_url)

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
