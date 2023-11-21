defmodule PepicrftWeb.Layouts do
  use PepicrftWeb, :html

  embed_templates "layouts/*"

  def feed_url do
    url = Application.fetch_env!(:pepicrft, :metadata) |> Keyword.fetch!(:base_url)
    url = %{url | path: "/blog/feed.xml"}
    url |> URI.to_string()
  end

  def something do
  end
end
