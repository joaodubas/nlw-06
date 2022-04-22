defmodule Wabanex.Users.Create do
  @moduledoc """
  Context for user creation.
  """
  alias Wabanex.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
