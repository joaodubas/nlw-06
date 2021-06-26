defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists returns calculated values" do
      params = %{"filename" => "students.csv"}

      imc = IMC.calculate(params)

      expected_imc = %{
        "Americo" => 24.508945765204302,
        "Ana" => 21.30394857667585,
        "Claudio" => 30.42184964845863,
        "João" => 31.88775510204082,
        "Luiz" => 27.777777777777775
      }

      assert {:ok, expected_imc} == imc
    end

    test "when the file is unavailable returns an error" do
      params = %{"filename" => "unavailable.csv"}

      imc = IMC.calculate(params)

      assert {:error, "Error while opening the file"} == imc
    end
  end
end
