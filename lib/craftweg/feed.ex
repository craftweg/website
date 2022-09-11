defmodule Craftweg.Feed do
  @doc """
  Given a list of posts, it returns the content of the RSS feed to be
  returned by the controller function that handles the RSS feed request.
  """
  @spec generate(list(%Craftweg.Blog.Post{})) :: any
  def generate(posts) do
    %{ title: title, description: description, language: language, base_url: base_url} = Application.fetch_env!(:craftweg, :metadata)

    channel =
      RSS.channel(
        title,
        base_url |> URI.to_string,
        description,
        Timex.now() |> Timex.format!("{RFC1123}"),
        language
      )

    item =
      RSS.item(
        "Item",
        "Description",
        "Date in RFC 1123 or RFC 882 format",
        "http://link.to.site/post",
        "guid-1234-aa"
      )

    feed = RSS.feed(channel, [item])
    feed
  end
end
