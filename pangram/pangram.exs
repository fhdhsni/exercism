defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
    sentence
    |> String.downcase
    |> String.replace(~r/[^a-z]/, "") # we don't care about anything other than a-z
    |> String.to_charlist
    |> Enum.sort
    |> Enum.dedup
    |> Enum.count == 26         # should be 26
  end
end
