defmodule WabanexWeb.Schema.Types.Custom.DateRange do
  use Absinthe.Schema.Notation

  alias Absinthe.Blueprint.Input

  scalar :date_range, name: "DateRange" do
    description("""
      The `DateRange` scalar represents a range/period of date. The `DateRange`
      appears as a string of two ISO8601 formatted dates separated by comma.
    """)

    serialize &serialize_range/1
    parse &parse_range/1
  end

  @spec serialize_range(PgRanges.DateRange.t()) :: String.t()
  @spec serialize_range(list(String.t())) :: String.t()
  defp serialize_range(%PgRanges.DateRange{lower: start_range, upper: end_range}),
    do: serialize_range([start_range, end_range])

  defp serialize_range([start_range, nil]), do: "#{Date.to_iso8601(start_range)},"

  defp serialize_range([start_range, end_range]),
    do: "#{Date.to_iso8601(start_range)},#{Date.to_iso8601(end_range)}"

  @spec parse_range(Input.String.t()) :: {:ok, PgRanges.DateRange.t()} | :error
  @spec parse_range(Input.Null.t()) :: {:ok, nil}
  defp parse_range(%Input.String{value: value}) do
    value
    |> String.split(",")
    |> Enum.map(&Date.from_iso8601/1)
    |> case do
      [{:error, _}] -> :error
      [{:error, _}, _] -> :error
      [_, {:error, _}] -> :error
      result -> {:ok, result |> Enum.map(fn {:ok, value} -> value end) |> new()}
    end
  end

  defp parse_range(%Input.Null{}), do: {:ok, nil}
  defp parse_range(_), do: :error

  defp new([start_date]), do: new([start_date, nil])
  defp new([start_date, end_date]), do: PgRanges.DateRange.new(start_date, end_date)
  defp new([]), do: new([nil, nil])
end
