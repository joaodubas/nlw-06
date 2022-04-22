defmodule WabanexWeb.Resolvers.Training do
  @moduledoc """
  GraphQL resolver for training operations.
  """
  alias Wabanex.Trainings

  def create(%{input: params}, _context), do: Trainings.Create.call(params)
end
