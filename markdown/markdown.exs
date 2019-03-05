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
    |> Enum.map_join("", &process/1)
    |> maybe_add_ul()
  end

  defp process(line) do
    cond do
      header?(line) ->
        line
        |> parse_header_md_level()
        |> enclose_with_header_tag()

      li?(line) ->
        parse_list_md_level(line)

      # it's a paragraph
      true ->
        line
        |> String.split()
        |> parse_words_with_md()
        |> enclose_with_tag("p")
    end
  end

  defp header?(line) do
    String.starts_with?(line, "#")
  end

  defp li?(line) do
    String.starts_with?(line, "*")
  end

  defp parse_header_md_level(header_line) do
    [sharps, text_content] =
      Regex.split(~r/#+/, header_line, parts: 2, include_captures: true, trim: true)

    {to_string(String.length(sharps)), String.trim(text_content)}
  end

  defp parse_list_md_level(list_line) do
    list_line
    |> String.trim_leading("* ")
    |> String.split()
    |> parse_words_with_md()
    |> enclose_with_tag("li")
  end

  defp enclose_with_header_tag({header_level, text_content}) do
    enclose_with_tag(text_content, "h" <> header_level)
  end

  defp enclose_with_tag(text_content, tag_str) do
    "<" <> tag_str <> ">" <> text_content <> "</" <> tag_str <> ">"
  end

  defp parse_words_with_md(word_list) do
    Enum.map_join(word_list, " ", &replace_md_with_tag/1)
  end

  defp replace_md_with_tag(word) do
    word
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  defp replace_prefix_md(word) do
    cond do
      word =~ ~r/^__/ -> String.replace(word, ~r/^__/, "<strong>", global: false)
      word =~ ~r/^_/ -> String.replace(word, ~r/_/, "<em>", global: false)
      true -> word
    end
  end

  defp replace_suffix_md(word) do
    cond do
      word =~ ~r/__$/ -> String.replace(word, ~r/__$/, "</strong>")
      word =~ ~r/_$/ -> String.replace(word, ~r/_$/, "</em>")
      true -> word
    end
  end

  defp maybe_add_ul(html_str) do
    html_str
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
