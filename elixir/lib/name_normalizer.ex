defmodule NameNormalizer do
  def normalize(name), do: name |> String.split() |> handle_parts

  defp handle_parts([]), do: {:ok, ""}
  defp handle_parts([single_name]), do: {:ok, single_name}
  defp handle_parts([first_name, last_name]), do: {:ok, "#{last_name}, #{first_name}"}
end
