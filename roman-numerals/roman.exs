defmodule Roman do
  @edges [M: 1000, CM: 900, D: 500, CD: 400, C: 100, XC: 90, L: 50, XL: 40, X: 10, IX: 9, V: 5, IV: 4, I: 1]

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    number
    |> count
    |> Enum.reverse
    |> List.to_string
  end

  def count(num, acc \\ [])
  def count(0, acc), do: acc
  def count(num, acc) do
    cond do
      num >= @edges[:M]  -> count(num - @edges[:M],  ["M" | acc])
      num >= @edges[:CM] -> count(num - @edges[:CM], ["CM" | acc])
      num >= @edges[:D]  -> count(num - @edges[:D],  ["D" | acc])
      num >= @edges[:CD] -> count(num - @edges[:CD], ["CD" | acc])
      num >= @edges[:C]  -> count(num - @edges[:C],  ["C" | acc])
      num >= @edges[:XC] -> count(num - @edges[:XC], ["XC" | acc])
      num >= @edges[:L]  -> count(num - @edges[:L],  ["L" | acc])
      num >= @edges[:XL] -> count(num - @edges[:XL], ["XL" | acc])
      num >= @edges[:X]  -> count(num - @edges[:X],  ["X" | acc])
      num >= @edges[:IX] -> count(num - @edges[:IX], ["IX" | acc])
      num >= @edges[:V]  -> count(num - @edges[:V],  ["V" | acc])
      num >= @edges[:IV] -> count(num - @edges[:IV], ["IV" | acc])
      true               -> count(num - @edges[:I],  ["I" | acc])
    end
  end
end
