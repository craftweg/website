defmodule Craftweg.Blog.Parser do
  @moduledoc """
  This module is a custom parser for NimblePublisher to extract the frontmatter delimited
  by the "---" delimiters.
  """
  def parser(path, contents) do
    {[], "body"}
  end
end
