defmodule WabanexWeb.IMCController do
  use WabanexWeb, :controller

  alias Wabanex.IMC

  def index(conn, params) do
    params
    |> IMC.calculate()
    |> handle_response(conn)
  end

  def handle_response({:ok, result}, conn), do: render_response(conn, :ok, result)
  def handle_response({:error, result}, conn), do: render_response(conn, :bad_request, result)

  defp render_response(conn, status, result) do
    conn
    |> put_status(status)
    |> json(%{result: result})
  end
end
