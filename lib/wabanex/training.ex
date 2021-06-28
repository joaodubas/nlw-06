defmodule Wabanex.Training do
  use Ecto.Schema

  import Ecto.Changeset

  alias PgRanges.DateRange
  alias Wabanex.{Exercise, User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields [:period, :user_id]

  schema "trainings" do
    field :period, DateRange, default: DateRange.new(Date.utc_today(), nil)

    belongs_to :user, User

    has_many :exercises, Exercise

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> exclusion_constraint(:period, name: :non_overlap_period)
    |> cast_assoc(:exercises)
  end
end
