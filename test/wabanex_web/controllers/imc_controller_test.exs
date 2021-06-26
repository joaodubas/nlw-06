defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid returns the imc info", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_response = %{
        "result" => %{
          "Americo" => 24.508945765204302,
          "Ana" => 21.30394857667585,
          "Claudio" => 30.42184964845863,
          "João" => 31.88775510204082,
          "Luiz" => 27.777777777777775
        }
      }

      assert expected_response == response
    end

    test "when params are invalid returns an error", %{conn: conn} do
      params = %{"filename" => "unavailable.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected_response = %{"result" => "Error while opening the file"}

      assert expected_response == response
    end
  end
end
