defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2, distance \\ 0)

  def hamming_distance(s1, s2, _distance) when length(s1) !== length(s2),
    do: {:error, "Lists must be the same length"}

  def hamming_distance([], [], distance), do: {:ok, distance}

  def hamming_distance([h | rest], [h2 | rest2], distance) do
    cond do
      h == h2 -> hamming_distance(rest, rest2, distance)
      true    -> hamming_distance(rest, rest2, distance + 1)
    end
  end
end
