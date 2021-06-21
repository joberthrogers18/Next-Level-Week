defmodule Wabanex.IMC  do
  def calculate(%{"filename" => filename}) do
    filename
    |> File.read()
    |> handle_file()
  end

  # defp because is a private function
  defp handle_file({:ok, content}) do
    data =
      content
      |> String.split("\n")
      |> Enum.map(fn elem -> parse_line(elem) end)
      |> Enum.into(%{})

    {:ok, data}
  end

  # defp because is a private function
  defp handle_file({:error, _}) do
    {:error, "Error while opening the file"}
  end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, fn elem -> String.trim(elem) end)
    |> List.update_at(2, fn elem -> String.trim(elem) end)
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
  end

  defp calculate_imc([name, height, weight]), do: {name, weight / (height * height)}
end
