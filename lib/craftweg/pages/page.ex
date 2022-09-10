defmodule Craftweg.Pages.Page do
  @moduledoc """
  A struct that represents a markdown page
  """
  defstruct [:path, :slug, :title, :body]

  @doc """
  Creates an instance of the Craftweg.Pages.Page struct from the
  body and frontmatter attributes parsed by Craftweg.Markdown.Parser.
  """
  @spec build(String.t, any, String.t) :: %Craftweg.Pages.Page{}
  def build(path, %{ "title" => title }, body) do
    slug = path |> Path.rootname() |> Path.split() |> Enum.take(-1) |> hd
    struct!(
      __MODULE__,
      path: path,
      slug: slug,
      title: title,
      body: body
    )
  end
end
