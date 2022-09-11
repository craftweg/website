defmodule Craftweg.Blog do
  alias Craftweg.Blog.Post
  alias Craftweg.Markdown.Parser

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:craftweg, "priv/posts/**/*.md"),
    as: :posts,
    parser: Parser,
    highlighters: [:makeup_ruby, :makeup_typescript, :makeup_elixir, :makeup_javascript, :makeup_swift, :makeup_erlang, :makeup_objective_c]

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})
  @categories @posts |> Enum.flat_map(& &1.categories) |> Enum.uniq() |> Enum.sort()
  @feed @posts |> Craftweg.Feed.generate()

  @doc """
  The function returns all the Craftweg.Blog.Post posts.
  """
  def all_posts, do: @posts

  @doc """
  The function returns all the categories.
  """
  def all_categories, do: @categories

  @doc """
  The function returns an RSS-formatted feed containing all the blog posts.
  """
  def feed, do: @feed
end
