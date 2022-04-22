defmodule WabanexWeb.Resolvers.User do
  @moduledoc """
  GraphQL resolver for user operations.
  """
  alias Wabanex.Users

  def get(%{id: user_id}, _context), do: Users.Get.call(user_id)

  def create(%{input: params}, _context), do: Users.Create.call(params)
end
