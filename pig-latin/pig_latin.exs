defmodule PigLatin do
  @vowels ["a", "e", "o", "u", "i", "yt", "xr"]
  @weirdos ["ch", "qu", "squ", "thr", "th", "sch"]

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(&decision_maker/1)
    |> Enum.map(&deal_with_vowels/1)
    |> Enum.map(&deal_with_consonants/1)
    |> Enum.reduce("", fn(word, acc) -> acc <> " #{word}" end)
    |> String.trim
  end

  defp decision_maker(word) do
    case String.starts_with?(word, @vowels) do
      true -> {:vowel, word}
      _    -> {:consonant, word}
    end
  end

  defp deal_with_consonants({:consonant, word}) do

    unless String.starts_with?(word, @weirdos) do
      word
      |> String.first
      |> remove_THIS_add_THAT("ay", word)
    else
      deal_with_weirdos(word)
    end

  end
  defp deal_with_consonants({_, word}), do: word

  defp deal_with_vowels({:vowel, word}), do: {:vowel, word <> "ay"}
  defp deal_with_vowels({status, word}), do: {status, word}

  defp remove_THIS_add_THAT(this, that, word) do
    String.replace(word, this, "", global: false)
    <> this
    <> that
  end

  defp deal_with_weirdos(word) do
    @weirdos
    |> Enum.find(&String.starts_with?(word, &1))
    |> remove_THIS_add_THAT("ay", word)
  end

end
