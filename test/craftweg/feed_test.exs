defmodule Craftweg.FeedTest do
  use ExUnit.Case
  import Craftweg.Feed
  import SweetXml

  test "generate returns the right content" do
    # Given
    posts = []

    # When
    feed = generate(posts)

    # Then
    assert feed |> xpath(~x"//channel/title/text()"s) == "Craftweg"
    assert feed |> xpath(~x"//channel/link/text()"s) == "https://craftweg.com"
    assert feed |> xpath(~x"//channel/description/text()"s) == "Description"
    assert feed |> xpath(~x"//channel/language/text()"s) == "en-us"

    %{year: last_build_year, month: last_build_month, day: last_build_day} =
      feed |> xpath(~x"//channel/lastBuildDate/text()"s) |> Timex.parse!("{RFC1123}")

    now = Timex.now()
    assert last_build_year == now.year
    assert last_build_month == now.month
    assert last_build_day == now.day
  end
end
