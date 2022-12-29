defmodule PepicrftWeb.CoreComponents do
  @moduledoc """
  Provides core UI components.

  The components in this module use Tailwind CSS, a utility-first CSS framework.
  See the [Tailwind CSS documentation](https://tailwindcss.com) to learn how to
  customize the generated components in this module.

  Icons are provided by [heroicons](https://heroicons.com), using the
  [heroicons_elixir](https://github.com/mveytsman/heroicons_elixir) project.
  """
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
      <article class="flex font-serif">
          <div class="flex-1 tracking-tight hover:text-rose-600">
              <% post_attributes = %{ href: post.slug } %>
              <a {post_attributes}><%= post.title  %></a>
          </div>
          <% {:ok, time_ago_date} = Elixir.Timex.Format.DateTime.Formatters.Relative.format(post.date, "{relative}") %>
          <div class="text-gray-400 text-sm"><%= time_ago_date %></div>
      </article>
    <% end %>
    """
  end

  def feed_url do
    %{base_url: url} = Application.fetch_env!(:pepicrft, :metadata)
    url = %{url | path: "/blog/feed.xml"}
    url |> URI.to_string()
  end

  def render("feed.xml", _assigns) do
    Pepicrft.Blog.feed()
  end

  # Metadata

  def metadata(_, %{page: %{title: title, description: description}}) do
    %{
      title: title,
      description: description
    }
  end

  def metadata(:blog_post, %{post: %{title: title, description: description}}) do
    title

    %{
      title: title,
      description: description
    }
  end
end
