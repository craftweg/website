defmodule CraftwegWeb.PageView do
  use CraftwegWeb, :view

  def posts() do
    Craftweg.Blog.all_posts()
  end
end
