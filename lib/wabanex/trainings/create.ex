defmodule Wabanex.Trainings.Create do
  @moduledoc """
  Context to create a training routine.
  """
  alias Wabanex.{Repo, Training}

  def call(params) do
    params
    |> Training.changeset()
    |> Repo.insert()
  end
end
