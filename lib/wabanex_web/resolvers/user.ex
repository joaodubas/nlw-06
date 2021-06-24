defmodule WabanexWeb.Resolvers.User do
  alias Wabanex.Users

  def get(%{id: user_id}, _context), do: Users.Get.call(user_id)
end
