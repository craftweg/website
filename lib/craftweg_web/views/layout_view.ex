defmodule CraftwegWeb.LayoutView do
  use CraftwegWeb, :view

  def title do
    Application.fetch_env!(:craftweg, :metadata) |> Keyword.fetch!(:title)
  end

  def feed_url do
    url = Application.fetch_env!(:craftweg, :metadata) |> Keyword.fetch!(:url) |> URI.parse()
    url = %{url | path: "/blog/feed.xml"}
    url |> URI.to_string()
  end

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}
end
