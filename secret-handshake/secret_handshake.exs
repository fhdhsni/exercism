defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    stuff = [
      {"jump", 1_000},
      {"close your eyes", 100},
      {"double blink", 10},
      {"wink", 1},
    ]

    bin =
      code
      |> Integer.digits(2)
      |> Integer.undigits()

      reverse_it? =  bin >= 10_000
      bin = if reverse_it?, do: rem(bin, 10_000), else: bin

      result =
        Enum.reduce(stuff, {[], bin}, fn(val, acc) ->
          secret = elem(acc, 0)
          bin = elem(acc, 1)
          number = elem(val, 1)
          if bin >= number do
            bin = rem(bin, number)
            secret = [elem(val, 0) | secret]
            {secret, bin}
          else
            {secret, bin}
          end
        end)
        |> elem(0)
      
      # jump? = bin >= 1_000
      # bin = if jump?, do: rem(bin, 1_000), else: bin

      # close_your_eyes? = bin >= 100
      # bin = if close_your_eyes?, do: rem(bin, 100), else: bin

      # double_blink? = bin >= 10
      # bin = if double_blink?, do: rem(bin, 10), else: bin

      # wink? = bin >= 1

      # secret = if jump?, do: ["jump" | secret], else: secret
      # secret = if close_your_eyes?, do: ["close your eyes" | secret], else: secret
      # secret = if double_blink?, do: ["double blink" | secret], else: secret
      # secret = if wink?, do: ["wink" | secret], else: secret

      result = if reverse_it?, do: Enum.reverse(result), else: result

      result
  end

end
