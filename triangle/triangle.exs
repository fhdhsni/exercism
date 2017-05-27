defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) do
    Enum.sort([a, b, c])
    |> check
  end

  def check([a, _, _]) when a <= 0, do: { :error, "all side lengths must be positive" }
  def check([a, b, c]) when a + b <= c, do: { :error, "side lengths violate triangle inequality" }
  def check([a, a, a]), do: { :ok, :equilateral }
  def check([a, a, _]), do: { :ok, :isosceles }
  def check([_, a, a]), do: { :ok, :isosceles }
  def check([_, _, _]), do: { :ok, :scalene }
end
