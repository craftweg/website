defmodule Pepicrft.Markdown.Parser do
  @moduledoc """
  This module is a custom parser for NimblePublisher to extract the frontmatter delimited
  by the "---" delimiters.
  """
  def parse(_, contents) do
    [frontmatter_string, body] =
      contents
      |> String.split("---\n", parts: 2, trim: true)

    frontmatter = YamlElixir.read_from_string!(frontmatter_string)

    {frontmatter, body}
  end
end
