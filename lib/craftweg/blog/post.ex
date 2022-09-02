defmodule Craftweg.Blog.Post do
  @moduledoc """
  This module is a struct that represents a blog post.
  """

  defstruct [:path, :slug, :title, :excerpt, :date, :categories, :body]

  def build(path, _attrs, body) do
    filename_without_extension = path |> Path.rootname() |> Path.split() |> Enum.take(-1) |> hd
    [year, month, day] = filename_without_extension |> String.split("-") |> Enum.take(3)
    date = Date.from_iso8601!("#{year}-#{month}-#{day}")
    slug = year <> "/" <> month <> "/" <> day <> "/" <> filename_without_extension

    struct!(
      __MODULE__,
      path: path,
      slug: slug,
      title: filename_without_extension,
      date: date,
      body: body,
      categories: [],
      excerpt: "",
    )
  end
end
