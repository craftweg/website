defmodule Craftweg.Blog do
  alias Craftweg.Blog.Post
  alias Craftweg.Markdown.Parser

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:craftweg, "priv/posts/**/*.md"),
    as: :posts,
    parser: Parser,
    highlighters: []

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})
  @categories @posts |> Enum.flat_map(& &1.categories) |> Enum.uniq() |> Enum.sort()
  @feed_xml @posts |> Enum.map(& &1)

  @doc """
  The function returns all the Craftweg.Blog.Post posts.
  """
  def all_posts, do: @posts

  @doc """
  The function returns all the categories.
  """
  def all_categories, do: @categories

  def feed_xml() do
    []
  end
end
