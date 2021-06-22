defmodule Wabanex.Users.Get do
  alias Wabanex.{Repo, User}

  def call(id) do
    id
    |> Ecto.UUID.cast()
    |> handle_result()
  end

  defp handle_result(:error), do: {:error, "Invalid id format"}

  defp handle_result({:ok, uuid}) do
    User
    |> Repo.get(uuid)
    |> case do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
