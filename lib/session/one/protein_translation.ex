defmodule Session.One.ProteinTranslation do
  @moduledoc false

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
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP",
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    proteins = rna
    |> String.to_charlist
    |> Stream.chunk_every(3)
    |> Stream.map(&List.to_string/1)
    |> Stream.map(&of_codon/1)
    |> Stream.map(fn {_, protein} -> protein end)
    |> Enum.take_while(&(&1 != "STOP"))

    if Enum.any?(proteins, &(&1 == "invalid codon")) do
      {:error, "invalid RNA"}
    else
      {:ok, proteins}
    end

  end

  @doc """
  Given a codon, return the corresponding protein as per @codon_table
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do 
    protein = Map.get(@codon_table, codon, :invalid)
    if protein == :invalid do 
      {:error, "invalid codon"}
    else
      {:ok, protein}
    end
  end
end
