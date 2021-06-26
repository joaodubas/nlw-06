defmodule Wabanex.Training do
  use Ecto.Schema

  import Ecto.Changeset

  alias Wabanex.{Exercise, User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields [:start_date, :end_date, :user_id]
  @required_fields [:start_date, :user_id]

  schema "trainings" do
    field :start_date, :date
    field :end_date, :date

    belongs_to :user, User

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
