defmodule PepicrftWeb.BlogXML do
  use PepicrftWeb, :xml

  embed_templates "blog_xml/*", ext: ".xml"
end
