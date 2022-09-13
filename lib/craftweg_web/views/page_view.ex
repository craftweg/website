defmodule CraftwegWeb.PageView do
  use CraftwegWeb, :view

  def posts() do
    Craftweg.Blog.all_posts()
  end

  def metadata(:markdown, %{page: %{title: title, description: description}}),
    do: %{
      title: title,
      description: description
    }
end
