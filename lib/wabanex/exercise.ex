defmodule Wabanex.Exercise do
  @moduledoc """
  Schema of a exercise contained within a training.
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias Wabanex.Training

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields [:name, :video_url, :protocol_description, :repetitions, :training_id]
  @required_fields [:name, :protocol_description, :repetitions]

  schema "exercises" do
    field :name, :string
    field :video_url, :string
    field :protocol_description, :string
    field :repetitions, :string

    belongs_to :training, Training

    timestamps()
  end

  def changeset(%__MODULE__{} = struct, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
