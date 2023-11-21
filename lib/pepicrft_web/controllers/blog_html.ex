defmodule PepicrftWeb.BlogHTML do
  use PepicrftWeb, :html

  embed_templates "blog_html/*"

  def metadata(:index, _) do
    %{
      title: "Blog",
      description: "Archive that contains all blog posts"
    }
  end

  def metadata(:show, %{
        post: %{title: title, description: description, og_image_slug: og_image_slug}
      }) do
    %{
      title: title,
      description: description,
      image:
        Application.fetch_env!(:pepicrft, :metadata)
        |> Keyword.fetch!(:base_url)
        |> URI.merge(og_image_slug)
        |> URI.to_string()
    }
  end
end
