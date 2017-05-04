defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    cleanify(str)
    |> Enum.reduce_while([], &reducer/2)
    |> (fn [] -> true; _ -> false end).()
  end
  
  def cleanify(str) do
    str
    |> String.replace(~r/[^\[\]\(\)\{\}]/, "") # remove non relevant chars
    |> String.split("", trim: true)
  end

  def reducer(cur, acc) do
    cond do
      cur == "]" -> pair?("[", acc)
      cur == ")" -> pair?("(", acc)
      cur == "}" -> pair?("{", acc)
      true       -> {:cont, [cur | acc]}
    end
  end

  def pair?(desired, [h | t]) when h == desired, do: {:cont, t}
  def pair?(_, _), do: {:halt, false}
end
