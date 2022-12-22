defmodule Pepicrft.FeedTest do
  use ExUnit.Case
  import Pepicrft.Feed
  import SweetXml

  test "generate returns the right content" do
    # Given
    posts = []

    # When
    feed = generate(posts)

    # Then
    %{title: title, description: description, base_url: base_url, language: language} =
      Application.fetch_env!(:pepicrft, :metadata)

    assert feed |> xpath(~x"//channel/title/text()"s) == title
    assert feed |> xpath(~x"//channel/link/text()"s) == base_url |> URI.to_string()
    assert feed |> xpath(~x"//channel/description/text()"s) == description
    assert feed |> xpath(~x"//channel/language/text()"s) == language

    %{year: last_build_year, month: last_build_month, day: last_build_day} =
      feed |> xpath(~x"//channel/lastBuildDate/text()"s) |> Timex.parse!("{RFC1123}")

    now = Timex.now()
    assert last_build_year == now.year
    assert last_build_month == now.month
    assert last_build_day == now.day
  end
end
