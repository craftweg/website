defmodule Pepicrft.Blog.Post do
  @max_og_image_title_length 27

  @moduledoc """
  This module is a struct that represents a blog post.
  """
  @enforce_keys [
    :path,
    :slug,
    :old_slug,
    :title,
    :description,
    :date,
    :categories,
    :body,
    :og_image_slug,
    :og_image_path
  ]
  defstruct [
    :path,
    :slug,
    :old_slug,
    :title,
    :description,
    :date,
    :categories,
    :body,
    :og_image_slug,
    :og_image_path
  ]

  @doc """
  This method takes the absolute path to the file representing a blog post,
  the contents of the file, and the attributes that have been generated by
  the parser and returns an instance of the Pepicrft.Blog.Post struct.
  """
  @type attributes :: any
  @spec build(String.t(), attributes, String.t()) :: %Pepicrft.Blog.Post{}
  def build(path, %{"title" => title, "categories" => categories} = frontmatter, body) do
    filename_without_extension = path |> Path.rootname() |> Path.split() |> Enum.take(-1) |> hd
    [year, month, day] = filename_without_extension |> String.split("-") |> Enum.take(3)
    date = Date.from_iso8601!("#{year}-#{month}-#{day}")

    description =
      frontmatter["description"] || (String.slice(body, 0..200) <> "...") |> html_to_text

    filename_without_date_and_extension =
      filename_without_extension |> String.replace("#{year}-#{month}-#{day}-", "")

    slug =
      "/blog/" <> year <> "/" <> month <> "/" <> day <> "/" <> filename_without_date_and_extension

    og_image_slug = "/images/og#{slug}.png"
    og_image_path = Application.app_dir(:pepicrft, "priv/static#{og_image_slug}")

    struct!(
      __MODULE__,
      path: path,
      old_slug: "/blog/" <> filename_without_date_and_extension,
      slug: slug,
      title: title,
      date: date,
      body: body,
      categories: categories,
      description: description,
      og_image_slug: og_image_slug,
      og_image_path: og_image_path
    )
  end

  @doc """
  This function takes a blog post and generates the Open Graph image for it.
  The function is intended to be used at build time.
  """
  @spec generate_og_image(%Pepicrft.Blog.Post{}) :: any
  def generate_og_image(post) do
    {title_line_1, title_line_2} = og_image_title_lines(post)
    categories = Enum.join(post.categories, ", ")

    svg = """
    <svg viewbox="0 0 1200 600" width="1200" height="600" xmlns="http://www.w3.org/2000/svg">
      <defs>
        <linearGradient y2="1" x2="1" y1="0.14844" x1="0.53125" id="gradient">
        <stop offset="0" stop-opacity="0.99609" stop-color="#463acb"/>
        <stop offset="0.99219" stop-opacity="0.97656" stop-color="#3851f5"/>
        </linearGradient>
      </defs>
      <g>
        <rect stroke="#000" height="800" width="1800" y="0" x="0" stroke-width="0" fill="url(#gradient)"/>
        <text font-style="normal" font-weight="normal" xml:space="preserve" text-anchor="start" font-family="'Alumni Sans'" font-size="70" y="250" x="100" stroke-width="0" stroke="#000" fill="#f8fafc">#{title_line_1}</text>
        <text font-style="normal" font-weight="normal" xml:space="preserve" text-anchor="start" font-family="'Alumni Sans'" font-size="70" y="350" x="100" stroke-width="0" stroke="#000" fill="#f8fafc">#{title_line_2}</text>
        <text font-style="normal" font-weight="normal" xml:space="preserve" text-anchor="start" font-family="'Alumni Sans'" font-size="30" y="550" x="50" stroke-width="0" stroke="#000" fill="#f8fafc" opacity="0.5">By Pedro Piñera</text>
        <text font-style="normal" font-weight="normal" xml:space="preserve" text-anchor="end" font-family="'Alumni Sans'" font-size="30" y="550" x="1150" stroke-width="0" stroke="#000" fill="#f8fafc" opacity="0.5">#{categories}</text>
      </g>
    </svg>
    """

    directory = post.og_image_path |> Path.dirname()

    if !File.exists?(directory) do
      File.mkdir_p!(directory)
    end

    if File.exists?(post.og_image_path) do
      File.rm!(post.og_image_path)
    end

    {image, _} = Vix.Vips.Operation.svgload_buffer!(svg)
    Image.write!(image, post.og_image_path)
  end

  @spec og_image_title_lines(%Pepicrft.Blog.Post{}) :: {String.t(), String.t()}
  defp og_image_title_lines(post) do
    post.title
    |> String.split(" ")
    |> Enum.reduce_while({"", ""}, fn word, {title_line_1, title_line_2} ->
      cond do
        String.length(title_line_1 <> " " <> word) <= @max_og_image_title_length ->
          {:cont, {title_line_1 <> " " <> word, title_line_2}}

        String.length(title_line_2 <> " " <> word) <= @max_og_image_title_length - 3 ->
          {:cont, {title_line_1, title_line_2 <> " " <> word}}

        true ->
          {:halt, {title_line_1, title_line_2 <> "..."}}
      end
    end)
  end

  defp html_to_text(html) do
    {:safe, html} =
      html
      |> String.replace(~r/<li>/, "\\g{1}- ", global: true)
      |> String.replace(
        ~r/<\/?\s?br>|<\/\s?p>|<\/\s?li>|<\/\s?div>|<\/\s?h.>/,
        "\\g{1}\n\r",
        global: true
      )
      |> PhoenixHtmlSanitizer.Helpers.sanitize(:strip_tags)

    html
  end
end
