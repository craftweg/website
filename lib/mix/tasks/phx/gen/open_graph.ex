defmodule Mix.Tasks.Phx.Gen.OpenGraph do
  use Mix.Task

  @shortdoc "Generates the Open Graph images for the blog posts"

  @moduledoc """
  A mix custom task that generates the Open Graph images for the blog posts.
  """

  def run(_) do
    Pepicrft.Blog.all_posts() |> Enum.each(&Pepicrft.Blog.Post.generate_og_image/1)
  end
end
