defmodule WabanexWeb.Schema.Types.Custom.DateRangeTest do
  use ExUnit.Case, async: true

  alias Absinthe.{Blueprint.Input, Type}
  alias PgRanges.DateRange
  alias WabanexWeb.Schema.Types

  defmodule TestSchema do
    use Absinthe.Schema

    import_types Types.Custom.DateRange

    query do
    end
  end

  defp serialize(type, value) do
    TestSchema.__absinthe_type__(type)
    |> Type.Scalar.serialize(value)
  end

  defp parse(type, value) do
    TestSchema.__absinthe_type__(type)
    |> Type.Scalar.parse(value)
  end

  describe ":date_range" do
    test "serialize a list of dates as a list of ISO8601 date strings" do
      assert "1978-12-15,1980-02-13" == serialize(:date_range, [~D[1978-12-15], ~D[1980-02-13]])
      assert "1978-12-15," == serialize(:date_range, [~D[1978-12-15], nil])
    end

    test "serialize a postgres range as a list of ISO8601 date strings" do
      assert "1978-12-15,1980-02-13" ==
               serialize(:date_range, DateRange.new(~D[1978-12-15], ~D[1980-02-13]))

      assert "1978-12-15," == serialize(:date_range, DateRange.new(~D[1978-12-15], nil))
    end

    test "can be parsed from a string of ISO8601" do
      assert {:ok, DateRange.new(~D[1978-12-15], ~D[1980-02-13])} ==
               parse(:date_range, %Input.String{value: "1978-12-15,1980-02-13"})

      assert {:ok, DateRange.new(~D[1978-12-15], nil)} ==
               parse(:date_range, %Input.String{value: "1978-12-15"})
    end
  end
end
