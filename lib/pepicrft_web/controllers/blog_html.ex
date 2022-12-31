defmodule PepicrftWeb.BlogHTML do
  use PepicrftWeb, :html

  embed_templates "blog_html/*"

  def metadata(:index, _) do
    %{
      title: "Blog",
      description: "Archive that contains all blog posts"
    }
  end

  def metadata(:show, %{post: %{title: title, description: description}}) do
    %{
      title: title,
      description: description
    }
  end
end
