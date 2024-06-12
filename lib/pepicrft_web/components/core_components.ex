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
    <div class="pp-Posts">
      <%= for post <- assigns.posts() do %>
        <% {:ok, time_ago_date} =
          Elixir.Timex.Format.DateTime.Formatters.Relative.format(post.date, "{relative}") %>
        <% post_attributes = %{href: post.slug} %>

        <a {post_attributes} class="pp-PostItem_Link">
          <div class="pp-PostItem">
            <div class="pp-PostItem_Date"><%= time_ago_date %></div>
            <h2 class="pp-PostItem_Title">
              <%= post.title %>
            </h2>
            <p class="pp-PostItem_Description"><%= post.description %></p>
          </div>
        </a>
      <% end %>
    </div>
    """
  end

  def description(assigns) do
    ~H"""
    <p class="pp-Header_Navigation-Description">
      I created <a href="https://github.com/tuist/xcodeproj">XcodeProj</a>
      and <a href="https://github.com/tuist/tuist">Tuist</a>. My work is trusted by companies like <a href="https://adidas.com">Adidas</a>, <a href="https://www.americanexpress.com">American Express</a>, and <a href="https://etsy.com">Etsy</a>. I enjoy building delightful tools for developers and open-source communities.
    </p>
    """
  end

  def meta(assigns) do
    ~H"""
    <title><%= get_metadata(@conn)[:title] %></title>
    <meta
      :if={@conn.assigns[:published_time] != nil}
      property="article:published_time"
      content={
        Timex.format!(
          Timex.to_datetime(Timex.to_naive_datetime(@conn.assigns[:published_time]), "Etc/UTC"),
          "{ISO:Extended}"
        )
      }
    />
    <meta name="description" content={get_metadata(@conn)[:description]} />
    <meta
      name="author"
      content={Application.fetch_env!(:pepicrft, :metadata) |> Keyword.fetch!(:author)}
    />
    <!-- Open graph -->
    <meta property="og:title" content={get_metadata(@conn)[:title]} />
    <meta property="og:description" content={get_metadata(@conn)[:description]} />
    <meta property="og:type" content="article" />
    <meta property="og:site_name" content="Pedro Piñera" />
    <meta property="og:url" content={Phoenix.Controller.current_url(@conn)} />
    <meta property="og:image" content={image(@conn)} />
    <!-- Twitter -->
    <meta name="twitter:card" content="summary" />
    <meta name="twitter:title" content={get_metadata(@conn)[:title]} />
    <meta name="twitter:description" content={get_metadata(@conn)[:description]} />
    <meta name="twitter:image" content={image(@conn)} />

    <meta
      name="twitter:site"
      content={Application.fetch_env!(:pepicrft, :metadata) |> Keyword.fetch!(:twitter_handle)}
    />
    <meta
      property="twitter:domain"
      content={Application.fetch_env!(:pepicrft, :metadata) |> Keyword.fetch!(:domain)}
    />
    <meta
      property="twitter:url"
      content={
        Application.fetch_env!(:pepicrft, :metadata) |> Keyword.fetch!(:base_url) |> URI.to_string()
      }
    />
    <!-- Favicon -->
    <link rel="shortcut icon" href={static_asset_url("/favicon.ico")} />
    <link
      rel="apple-touch-icon"
      sizes="180x180"
      href={static_asset_url("/favicon/apple-touch-icon.png")}
    />
    <link
      rel="icon"
      type="image/png"
      sizes="32x32"
      href={static_asset_url("/favicon/favicon-32x32.png")}
    />
    <link
      rel="icon"
      type="image/png"
      sizes="16x16"
      href={static_asset_url("/favicon/favicon-16x16.png")}
    />
    <link rel="manifest" href={static_asset_url("/favicon/site.webmanifest")} />
    <meta name="msapplication-TileColor" content="#da532c" />
    <meta name="theme-color" content="#ffffff" />
    """
  end

  def image(_conn) do
    # metadata_image = get_metadata(conn)[:image]
    static_asset_url("/images/avatar.jpeg")
  end

  defp static_asset_url(path) do
    Application.fetch_env!(:pepicrft, :metadata)
    |> Keyword.fetch!(:base_url)
    |> URI.merge(path)
    |> URI.to_string()
  end
end
