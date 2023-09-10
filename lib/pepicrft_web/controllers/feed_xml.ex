defmodule PepicrftWeb.FeedXML do
  use PepicrftWeb, :xml

  embed_templates "feed_xml/*"

  use Timex

  def to_rfc3339(date) do
    date
    |> Timezone.convert("GMT")
    |> Timex.format!("{RFC3339}")
  end
end
