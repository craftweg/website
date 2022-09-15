defmodule CraftwegWeb.PageView do
  use CraftwegWeb, :view

  def posts() do
    Craftweg.Blog.all_posts()
  end

  def metadata(:markdown, %{page: %{title: title, description: description}}),
    do: %{
      title: title,
      description: description
    }
  def posts_component(assigns) do
    assigns = if assigns |> Map.has_key?(:take) do
      Phoenix.LiveView.assign(assigns, :posts,  assigns.posts |> Enum.take(assigns.take))
    else
      assigns
    end

    ~H"""
    <%= for post <- assigns.posts() do %>
      <article class="flex gap-3 font-sans text-lg">
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
end
