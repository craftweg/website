defmodule Pepicrft.Pages do
  @moduledoc """
  This module embeds all the markdown pages in the priv/pages directory
  at compile them and provides functions for accessing them.
  """
  alias Pepicrft.Pages.Page
  alias Pepicrft.Markdown.Parser

  use NimblePublisher,
    build: Page,
    from: Application.app_dir(:pepicrft, "priv/pages/**/*.md"),
    as: :pages,
    parser: Parser,
    highlighters: []

  @doc """
  Returns all the markdown pages in the priv/pages directory of the
  project
  """
  def all_pages, do: @pages
end
