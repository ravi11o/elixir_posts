defmodule ElixirpostsWeb.PageView do
  use ElixirpostsWeb, :view
  import Scrivener.HTML

  def day(date) do
    date
    |> String.split([" ", ", "], trim: true)
    |> get_day
  end

  def month(date) do
    date
    |> String.split([" ", ", "], trim: true)
    |> get_month
  end

  defp get_day([day | _rest]) do
    day
  end

  defp get_month([_day, month | _rest]) do
    month
  end


end
