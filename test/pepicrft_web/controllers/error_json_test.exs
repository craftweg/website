defmodule PepicrftWeb.ErrorJSONTest do
  use PepicrftWeb.ConnCase, async: true

  test "renders 404" do
    assert PepicrftWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert PepicrftWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
