defmodule Raindrops do
  @spec convert(pos_integer) :: String.t
  def convert(num) do
    num
    |> gimme_factors()
    |> Enum.map(fn 3 -> "Pling"; 5 -> "Plang"; 7 -> "Plong" end)
    |> preparation(num)
  end

  defp gimme_factors(num, we_care \\ [3, 5, 7]), do: Enum.filter(we_care, &rem(num, &1) == 0)
  defp preparation([], n), do: Integer.to_string(n)
  defp preparation(list, _n), do: List.to_string(list)
end
