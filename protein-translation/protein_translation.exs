defmodule ProteinTranslation do
  @stuff  %{ "UGU" => "Cysteine",
             "UGC" => "Cysteine",
             "UUA" => "Leucine",
             "UUG" => "Leucine",
             "AUG" => "Methionine",
             "UUU" => "Phenylalanine",
             "UUC" => "Phenylalanine",
             "UCU" => "Serine",
             "UCC" => "Serine",
             "UCA" => "Serine",
             "UCG" => "Serine",
             "UGG" => "Tryptophan",
             "UAU" => "Tyrosine",
             "UAC" => "Tyrosine",
             "UAA" => "STOP",
             "UAG" => "STOP",
             "UGA" => "STOP", }
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
      rna
      |> String.split(~r/\w{3}/, include_captures: true, trim: true)
      |> Enum.map(&of_codon/1)
      |> Keyword.values
      |> remove_from_STOP_to_the_end
      |> check_validity
  end

  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case Map.fetch(@stuff, codon) do
      :error -> { :error, "invalid codon" }
      result -> result
    end
  end

  def remove_from_STOP_to_the_end(list) do
    case Enum.find_index(list, &(&1 == "STOP")) do
      nil -> list
      index -> Enum.take(list, index)
    end
  end

  def check_validity(list) do
    case Enum.find_index(list, &(&1 == "invalid codon")) do
      nil -> {:ok, list}
      _ -> {:error, "invalid RNA"}
    end
  end
end

