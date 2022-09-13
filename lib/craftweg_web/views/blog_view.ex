defmodule CraftwegWeb.BlogView do
  use CraftwegWeb, :view

  def render("feed.xml", assigns) do
    Craftweg.Blog.feed()
  end

  # Metadata

  def metadata(:post, %{post: %{title: title, description: description}}),
    do: %{
      title: title,
      description: description
    }
end
