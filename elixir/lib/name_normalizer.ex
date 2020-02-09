defmodule NameNormalizer do
  def normalize(name), do: name |> String.split() |> handle_parts()

  defp handle_parts([]), do: {:ok, ""}
  defp handle_parts([single_name]), do: {:ok, single_name}
  defp handle_parts([first_name, last_name]), do: {:ok, "#{last_name}, #{first_name}"}

  defp handle_parts([first_name | other_names]) do
    {middle_names, last_name} = Enum.split(other_names, -1)
    {:ok, Enum.join(["#{last_name},", first_name, initials(middle_names)], " ")}
  end

  defp initials(middle_names) do
    middle_names |> Enum.map(&initial/1) |> Enum.join(" ")
  end

  defp initial(<<_>> = name), do: String.at(name, 0)
  defp initial(name), do: "#{String.at(name, 0)}."
end
