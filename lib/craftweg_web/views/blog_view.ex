defmodule CraftwegWeb.BlogView do
  use CraftwegWeb, :view

  def render("feed.xml", assigns) do
    Craftweg.Blog.feed()
  end
end
