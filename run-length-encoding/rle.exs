defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(str) do
    str                         # "wwwff"
    |> String.to_charlist       # 'wwwff'
    |> Enum.reduce([], &reducer/2) # [{2, 'f'}, {3, 'w'}]
    |> Enum.reverse                # [{3, 'w'}, {2, 'f'}]
    |> Enum.map(&stringify/1)      # ["3w", "2f"]
    |> List.to_string              # "3w2f"
  end

  defp reducer(x, []), do: [{1, x}]
  defp reducer(x, [{counter, char} | t]) when x == char do
    acc = [{counter, char} | t]
    List.replace_at(acc, 0, {counter + 1, char})
  end
  defp reducer(x, acc), do: [{1, x} | acc]

  defp stringify({1, char}), do: <<char>>
  defp stringify({counter, char}), do: to_string(counter) <> <<char>>
  
  ###############
  # decode
  ###############
  @spec decode(String.t) :: String.t
  def decode(str) do                             # "12f X2o"
    Regex.scan(~r/\d*(.)/, str, capture: :first) # [["12f"], [" "], ["X"], ["2o"]]
    |> List.flatten             # ["12f", " ", "X", "2o"]
    |> Enum.map(&mapper/1)      # ["ffffffffffff", " ", "X", "oo"]
    |> List.to_string
  end

  defp mapper(<<x>>), do: <<x>>
  defp mapper(item) do           # item => e.g. "12f"
    Regex.split(~r/\d+/, item, include_captures: true, trim: true)
    |> create_string
  end
  defp create_string([num, char]) do
    String.duplicate(char, String.to_integer(num))
  end

end
