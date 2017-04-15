defmodule NucleotideCount do
  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    strand
    |> Enum.filter(&(&1 == nucleotide))
    |> length
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    [a, t, c, g] = [?A, ?T, ?C, ?G]
    
    result = %{
      a => 0,
      t => 0,
      c => 0,
      g => 0
    }
    
    result = Enum.reduce(strand, result, fn(el, acc) -> 
      case el do
        ?A -> %{acc | a => acc[a] + 1}
        ?T -> %{acc | t => acc[t] + 1}
        ?C -> %{acc | c => acc[c] + 1}
        ?G -> %{acc | g => acc[g] + 1}
      end
    end)

    result
  end
end
