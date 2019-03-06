defmodule Grains do
  use Bitwise

  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) do
    cond do
      number <= 64 and number >= 1 ->
        # {:ok, trunc(:math.pow(2, number - 1))}
        {:ok, 1 <<< (number - 1)}

      true ->
        {:error, "The requested square must be between 1 and 64 (inclusive)"}
    end
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    # {:ok, Enum.reduce(0..63, 0, fn num, acc -> acc + (1 <<< num) end)}
    {:ok, (1 <<< 64) - 1}
  end
end
