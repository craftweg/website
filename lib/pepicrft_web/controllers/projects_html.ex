defmodule PepicrftWeb.ProjectsHTML do
  use PepicrftWeb, :html

  embed_templates "projects_html/*"

  def metadata(:index, _) do
    %{
      title: "Projects",
      description: "A list of projects that I have worked on and am currently working on."
    }
  end
end
