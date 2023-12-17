defmodule Pepicrft.Blog do
  alias Pepicrft.Blog.Post
  alias Pepicrft.Markdown.Parser

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:pepicrft, "priv/posts/**/*.md"),
    as: :posts,
    parser: Parser,
    highlighters: []

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})
  @categories @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

  @doc """
  The function returns all the Pepicrft.Blog.Post posts.
  """
  def all_posts, do: @posts

  @doc """
  The function returns all the categories.
  """
  def all_tags, do: @tags
end
