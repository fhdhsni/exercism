defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&process/1)
    |> Enum.join()
    |> maybe_add_ul()
  end

  def process(line) do
    cond do
      is_header?(line) ->
        line
        |> parse_header_md_level()
        |> enclose_with_header_tag()

      is_li?(line) ->
        parse_list_md_level(line)

      # it's a paragraph
      true ->
        line
        |> String.split()
        |> parse_words_with_md()
        |> enclose_with_tag("p")
    end
  end

  def is_header?(line) do
    String.starts_with?(line, "#")
  end

  def is_li?(line) do
    String.starts_with?(line, "*")
  end

  def parse_header_md_level(header_line) do
    [sharps, text_content] =
      Regex.split(~r/#+/, header_line, parts: 2, include_captures: true, trim: true)

    {to_string(String.length(sharps)), String.trim(text_content)}
  end

  def parse_list_md_level(list_line) do
    list_line
    |> String.trim_leading("* ")
    |> String.split()
    |> parse_words_with_md()
    |> enclose_with_tag("li")
  end

  def enclose_with_header_tag({header_level, text_content}) do
    enclose_with_tag(text_content, "h" <> header_level)
  end

  def enclose_with_tag(text_content, tag_str) do
    "<" <> tag_str <> ">" <> text_content <> "</" <> tag_str <> ">"
  end

  def parse_words_with_md(word_list) do
    word_list
    |> Enum.map(&replace_md_with_tag/1)
    |> Enum.join(" ")
  end

  def replace_md_with_tag(word) do
    word
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  def replace_prefix_md(word) do
    cond do
      word =~ ~r/^__/ -> String.replace(word, ~r/^__/, "<strong>", global: false)
      word =~ ~r/^_/ -> String.replace(word, ~r/_/, "<em>", global: false)
      true -> word
    end
  end

  def replace_suffix_md(word) do
    cond do
      word =~ ~r/__$/ -> String.replace(word, ~r/__$/, "</strong>")
      word =~ ~r/_$/ -> String.replace(word, ~r/_$/, "</em>")
      true -> word
    end
  end

  def maybe_add_ul(html_str) do
    html_str
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
