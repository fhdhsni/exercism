defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b, status \\ nil)

  def compare(a, b, _) when length(a) == length(b) and a !== b,  do: :unequal
  def compare(a, b, :sublist) when a === b,  do: :sublist
  def compare(a, b, _) when a === b,  do: :equal
  def compare([], _, _), do: :sublist
  def compare(a, b, _) when length(a) < length(b) do
    b
    |> Enum.chunk(length(a))
    |> Enum.member?(a)
    |> check(a, b)
  end

  def compare(a, b, _) when length(a) > length(b) do
    case compare(b, a) do
      :sublist -> :superlist
      _        ->
        [_whatever | tail_a] = a
        compare(b, tail_a)
    end
  end

  def check(true, _a, _b),  do: :sublist
  def check(_result, a, [_whatever | tail_b]) do
    compare(a, tail_b, :sublist)
  end
end
