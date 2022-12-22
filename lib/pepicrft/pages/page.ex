defmodule Pepicrft.Pages.Page do
  @moduledoc """
  A struct that represents a markdown page
  """
  defstruct [:path, :slug, :title, :body, :description, :identifier]

  @doc """
  Creates an instance of the Pepicrft.Pages.Page struct from the
  body and frontmatter attributes parsed by Pepicrft.Markdown.Parser.
  """
  @spec build(String.t(), any, String.t()) :: %Pepicrft.Pages.Page{}
  def build(path, %{"title" => title, "description" => description}, body) do
    slug = "/" <> (path |> Path.rootname() |> Path.split() |> Enum.take(-1) |> hd)
    identifier = path |> Path.basename(".md")

    struct!(
      __MODULE__,
      path: path,
      slug: slug,
      title: title,
      description: description,
      body: body,
      identifier: identifier
    )
  end
end
