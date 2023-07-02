defmodule PepicrftWeb.FeedXML do
  use PepicrftWeb, :xml

  embed_templates "feed_xml/*"

  use Timex

  def to_rfc3339(date) do
    date
    |> Timezone.convert("GMT")
    |> Timex.format!("{RFC3339}")
  end

  def just_for_fun_sign_up_html_footer do
    """
    <h2>Subscribe to my newsletter</h2>
    <p>
      <b>Just for Fun</b> is a more intimate space where I share in-depth experiences and lessons learned from crafting software and making a living out of it. It's sent every Saturday morning.
    </p>
    <p>
      <a href="https://justforfun.pepicrft.me/signup">Subscribe</a>
    </p>
    """
  end
end
