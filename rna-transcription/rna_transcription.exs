defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.map(fn strand ->
      cond do
        strand == ?G -> ?C
        strand == ?C -> ?G
        strand == ?T -> ?A
        strand == ?A -> ?U
      end
    end)
  end
end
