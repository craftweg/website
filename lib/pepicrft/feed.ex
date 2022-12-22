defmodule Pepicrft.Feed do
  @doc """
  Given a list of posts, it returns the content of the RSS feed to be
  returned by the controller function that handles the RSS feed request.
  """
  @spec generate(list(%Pepicrft.Blog.Post{})) :: any
  def generate(posts) do
    Application.ensure_all_started(:timex)

    %{title: title, description: description, language: language, base_url: base_url} =
      Application.fetch_env!(:pepicrft, :metadata)

    channel =
      RSS.channel(
        title,
        base_url |> URI.to_string(),
        description,
        Timex.now() |> Timex.format!("{RFC1123}"),
        language
      )

    items =
      posts
      |> Enum.map(fn post ->
        post_url = %{base_url | path: post.slug} |> URI.to_string()
        guid = %{base_url | path: post.old_slug} |> URI.to_string()
        pub_date = post.date |> Timex.to_datetime("Europe/Berlin") |> Timex.format!("{RFC822}")

        """
        <item>
          <title>#{post.title}</title>
          <description><![CDATA[#{post.description}]]></description>
          <author>hola@pepicrft.com</author>
          <pubDate>#{pub_date}</pubDate>
          <link>#{post_url}</link>
          <guid>#{guid}</guid>
          <content><![CDATA[#{post.body}]]></content>
        </item>
        """
      end)

    feed = RSS.feed(channel, items)
    feed
  end
end
