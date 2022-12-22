defmodule PepicrftWeb.LayoutView do
  use PepicrftWeb, :view

  def feed_url do
    %{base_url: url} = Application.fetch_env!(:pepicrft, :metadata)
    url = %{url | path: "/blog/feed.xml"}
    url |> URI.to_string()
  end

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}
end
