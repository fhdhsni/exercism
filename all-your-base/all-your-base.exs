defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, a, b) when digits === [] or a <= 1 or b <= 1, do: nil
  def convert(digits, a, b), do: digits |> from_base_a(a, 0) |> to_base_b(b, [])

  @spec from_base_a(list, integer, integer) :: integer
  def from_base_a([], _, acc), do: acc
  def from_base_a([hd | _], a, _) when hd < 0 or hd >= a, do: nil
  def from_base_a([hd | tl], a, acc), do: from_base_a(tl, a, acc * a + hd)

  @spec to_base_b(integer, integer, list) :: list
  def to_base_b(nil, _, _), do: nil
  def to_base_b(0, _, []), do: [0]
  def to_base_b(0, _, acc), do: acc
  def to_base_b(n, b, acc), do: to_base_b(div(n, b), b, [rem(n, b) | acc])
end
