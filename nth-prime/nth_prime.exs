defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count < 1, do: raise "hah?"
  def nth(count) do
    Stream.iterate(2, &find_next_prime/1)
    |> Enum.take(count)
    |> Enum.at(count - 1)
  end

  def find_next_prime(prev) do
    next = prev + 1

    if prime?(next),
      do: next,
      else: find_next_prime(next)
  end
  
  def prime?(num, possible_factor \\ 2)
  def prime?(num, possible_factor) when possible_factor > num / 2,
    do: true
  def prime?(num, possible_factor) when rem(num, possible_factor) == 0,
    do: false
  def prime?(num, possible_factor),
    do: prime?(num, possible_factor + 1)
end
