defmodule PepicrftWeb.CoreComponents do
  @moduledoc """
  Provides core UI components.

  The components in this module use Tailwind CSS, a utility-first CSS framework.
  See the [Tailwind CSS documentation](https://tailwindcss.com) to learn how to
  customize the generated components in this module.

  Icons are provided by [heroicons](https://heroicons.com), using the
  [heroicons_elixir](https://github.com/mveytsman/heroicons_elixir) project.
  """
  use PepicrftWeb.Meta
  use Phoenix.Component

  def posts_component(assigns) do
    assigns =
      if assigns |> Map.has_key?(:take) do
        Phoenix.Component.assign(assigns, :posts, assigns.posts |> Enum.take(assigns.take))
      else
        assigns
      end

    ~H"""
    <%= for post <- assigns.posts() do %>
      <article class="flex flex-col sm:flex-row font-sans">
          <div class="flex-1 tracking-tight hover:text-indigo-600">
              <% post_attributes = %{ href: post.slug } %>
              <a {post_attributes}><%= post.title  %></a>
          </div>
          <% {:ok, time_ago_date} = Elixir.Timex.Format.DateTime.Formatters.Relative.format(post.date, "{relative}") %>
          <div class="text-gray-400 text-sm"><%= time_ago_date %></div>
      </article>
    <% end %>
    """
  end

  def meta(assigns) do
    ~H"""
      <title><%= get_metadata(@conn)[:title] %></title>
      <meta property="article:published_time" content="2022-09-07T00:00:00+00:00">
      <meta name="description" content={get_metadata(@conn)[:description]}>
      <meta name="author" content={Application.fetch_env!(:pepicrft, :metadata).author}>

      <!-- Open graph -->
      <meta property="og:title" content={get_metadata(@conn)[:title]}>
      <meta property="og:description" content={get_metadata(@conn)[:description]}>
      <meta property="og:type" content="article">
      <meta property="og:site_name" content="Pedro Piñera">
      <meta property="og:url" content={Phoenix.Controller.current_url(@conn)}>
      <meta property="og:image" content={image(@conn)}>


      <!-- Twitter -->
      <meta property="twitter:image" content={image(@conn)}>
      <meta name="twitter:card" content="summary">
      <meta name="twitter:title" content={get_metadata(@conn)[:title]}>
      <meta name="twitter:description" content={get_metadata(@conn)[:description]}>
      <meta name="twitter:site" content={Application.fetch_env!(:pepicrft, :metadata).twitter_handle}>
      <meta property="twitter:domain" content={Application.fetch_env!(:pepicrft, :metadata).domain}>
      <meta property="twitter:url" content={Application.fetch_env!(:pepicrft, :metadata).base_url |> URI.to_string}>

      <!-- Favicon -->
      <link rel="shortcut icon"  href={static_asset_url("/favicon.ico")}/>
      <link rel="apple-touch-icon" sizes="180x180" href={static_asset_url("/favicon/apple-touch-icon.png")}>
      <link rel="icon" type="image/png" sizes="32x32" href={static_asset_url("/favicon/favicon-32x32.png")}>
      <link rel="icon" type="image/png" sizes="16x16" href={static_asset_url("/favicon/favicon-16x16.png")}>
      <link rel="manifest" href={static_asset_url("/favicon/site.webmanifest")}>
      <meta name="msapplication-TileColor" content="#da532c">
      <meta name="theme-color" content="#ffffff">
    """
  end

  def image(conn) do
    static_asset_url("/images/logo.jpg")
  end

  defp static_asset_url(path) do
    Application.fetch_env!(:pepicrft, :metadata).base_url |> URI.merge(path) |> URI.to_string
  end
end
