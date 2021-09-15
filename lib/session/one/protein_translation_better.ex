defmodule Session.One.ProteinTranslationBetter do
  @codon_table %{
    "UGU" => "Cysteine",
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
    "UAA" => :stop,
    "UAG" => :stop,
    "UGA" => :stop
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna), do: ribosome(rna, [])

  defp ribosome(<<>>, proteins), do: {:ok, proteins}

  defp ribosome(<<codon::binary-size(3), rest::binary>>, proteins) do
    case of_codon(codon) do
      {:error, _} -> {:error, "invalid RNA"}
      {:ok, :stop} -> {:ok, proteins}
      {:ok, protein} -> ribosome(rest, proteins ++ [protein])
    end
  end

  @doc """
  Given a codon, return the corresponding protein as per @codon_table
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.get(@codon_table, codon, :invalid) do
      :invalid -> {:error, "invalid codon"}
      protein -> {:ok, protein}
    end
  end
end
