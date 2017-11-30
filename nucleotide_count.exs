defmodule NucleotideCount do
  # @nucleotides [?A, ?C, ?G, ?T]

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
      |> List.to_string
      |> String.graphemes
      |> Enum.reduce(0, fn x, acc -> if x == << nucleotide :: utf8 >>, do: acc + 1, else: acc end)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    strand
    |> List.to_string
    |> String.graphemes
    |> Enum.reduce(%{?A => 0, ?T => 0, ?C => 0, ?G => 0},
      fn x, acc -> Map.replace(acc, x |> get_code, acc[x |> get_code]+1) end
    )
  end

  defp get_code x do
    x |> String.to_charlist |> List.first
  end
end

