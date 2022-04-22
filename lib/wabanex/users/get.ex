defmodule Wabanex.Users.Get do
  @moduledoc """
  Context to fetch a given user and its current training.
  """
  import Ecto.Query

  alias Wabanex.{Repo, Training, User}

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
      user -> {:ok, load_training(user)}
    end
  end

  defp load_training(%User{} = user) do
    today = Date.utc_today()

    query =
      from(t in Training,
        where: fragment("?::date <@ ?", ^today, t.period)
      )

    Repo.preload(user, trainings: {first(query, :inserted_at), :exercises})
  end
end
