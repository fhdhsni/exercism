defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase
    |> String.split("")
    |> Enum.map(&score_of_letter/1)
    |> Enum.sum
  end

  def score_of_letter(""), do: 0
  def score_of_letter(<<c>>) do
    cond do
      c in 'AEIOULNRST' -> 1
      c in 'DG'         -> 2
      c in 'BCMP'       -> 3
      c in 'FHVWY'      -> 4
      c in 'K'          -> 5
      c in 'JX'         -> 8
      c in 'QZ'         -> 10
      true              -> 0
    end
  end
end
