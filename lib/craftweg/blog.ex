defmodule Craftweg.Blog do
  alias Craftweg.Blog.Post
  alias Craftweg.Blog.Parser

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:craftweg, "priv/posts/**/*.md"),
    as: :posts,
    parser: Parser,
    highlighters: []

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  def all_posts, do: @posts
end
