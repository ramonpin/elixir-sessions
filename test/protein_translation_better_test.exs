defmodule ProteinTranslationBetterTest do
  use ExUnit.Case
  alias Session.One.ProteinTranslationBetter

  # @tag :pending
  test "AUG translates to methionine" do
    assert ProteinTranslationBetter.of_codon("AUG") == {:ok, "Methionine"}
  end

  # @tag :pending
  test "identifies Phenylalanine codons" do
    assert ProteinTranslationBetter.of_codon("UUU") == {:ok, "Phenylalanine"}
    assert ProteinTranslationBetter.of_codon("UUC") == {:ok, "Phenylalanine"}
  end

  # @tag :pending
  test "identifies Leucine codons" do
    assert ProteinTranslationBetter.of_codon("UUA") == {:ok, "Leucine"}
    assert ProteinTranslationBetter.of_codon("UUG") == {:ok, "Leucine"}
  end

  # @tag :pending
  test "identifies Serine codons" do
    assert ProteinTranslationBetter.of_codon("UCU") == {:ok, "Serine"}
    assert ProteinTranslationBetter.of_codon("UCC") == {:ok, "Serine"}
    assert ProteinTranslationBetter.of_codon("UCA") == {:ok, "Serine"}
    assert ProteinTranslationBetter.of_codon("UCG") == {:ok, "Serine"}
  end

  # @tag :pending
  test "identifies Tyrosine codons" do
    assert ProteinTranslationBetter.of_codon("UAU") == {:ok, "Tyrosine"}
    assert ProteinTranslationBetter.of_codon("UAC") == {:ok, "Tyrosine"}
  end

  # @tag :pending
  test "identifies Cysteine codons" do
    assert ProteinTranslationBetter.of_codon("UGU") == {:ok, "Cysteine"}
    assert ProteinTranslationBetter.of_codon("UGC") == {:ok, "Cysteine"}
  end

  # @tag :pending
  test "identifies Tryptophan codons" do
    assert ProteinTranslationBetter.of_codon("UGG") == {:ok, "Tryptophan"}
  end

  # @tag :pending
  test "identifies stop codons" do
    assert ProteinTranslationBetter.of_codon("UAA") == {:ok, :stop}
    assert ProteinTranslationBetter.of_codon("UAG") == {:ok, :stop}
    assert ProteinTranslationBetter.of_codon("UGA") == {:ok, :stop}
  end

  # @tag :pending
  test "translates rna strand into correct protein" do
    strand = "AUGUUUUGG"
    assert ProteinTranslationBetter.of_rna(strand) == {:ok, ~w(Methionine Phenylalanine Tryptophan)}
  end

  # @tag :pending
  test "stops translationBetter if stop codon present" do
    strand = "AUGUUUUAA"
    assert ProteinTranslationBetter.of_rna(strand) == {:ok, ~w(Methionine Phenylalanine)}
  end

  # @tag :pending
  test "stops translationBetter of longer strand" do
    strand = "UGGUGUUAUUAAUGGUUU"
    assert ProteinTranslationBetter.of_rna(strand) == {:ok, ~w(Tryptophan Cysteine Tyrosine)}
  end

  # @tag :pending
  test "invalid RNA" do
    assert ProteinTranslationBetter.of_rna("CARROT") == {:error, "invalid RNA"}
  end

  # @tag :pending
  test "invalid codon at end of RNA" do
    assert ProteinTranslationBetter.of_rna("UUUROT") == {:error, "invalid RNA"}
  end

  # @tag :pending
  test "invalid codon" do
    assert ProteinTranslationBetter.of_codon("INVALID") == {:error, "invalid codon"}
  end
end
