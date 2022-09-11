defmodule Craftweg.Feed do
  @doc """
  Given a list of posts, it returns the content of the RSS feed to be
  returned by the controller function that handles the RSS feed request.
  """
  @spec generate(list(%Craftweg.Blog.Post{})) :: any
  def generate(posts) do
    channel =
      RSS.channel(
        "Craftweg",
        "https://craftweg.com",
        "Description",
        Timex.now() |> Timex.format!("{RFC1123}"),
        "en-us"
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
