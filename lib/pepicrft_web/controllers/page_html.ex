defmodule PepicrftWeb.PageHTML do
  use PepicrftWeb, :html

  embed_templates "page_html/*"

  def metadata(_, %{page: %{title: title, description: description}}) do
    %{
      title: title,
      description: description
    }
  end
end
