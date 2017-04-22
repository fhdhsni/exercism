defmodule StringSeries do
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    s
    |> String.graphemes
    |> do_slices(size)
  end
  
  defp do_slices(list, size, acc \\ [])
  defp do_slices(_list, size, _acc) when size <= 0, do: []
  defp do_slices([], size, acc) do
    acc
    |> Enum.reverse
    |> Enum.filter(fn slice -> length(slice) >= size end)
    |> Enum.map(fn slice -> List.to_string slice end)
  end

  defp do_slices(list, size, acc) do
    [_h | rest] = list
    newSlice = Enum.take(list, size)
    do_slices(rest, size, [newSlice | acc])
  end
end

