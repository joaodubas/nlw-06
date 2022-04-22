defmodule WabanexWeb.Schema.Types.Training do
  @moduledoc """
  GraphQL training type definition.
  """
  use Absinthe.Schema.Notation

  import_types WabanexWeb.Schema.Types.Custom.DateRange
  import_types WabanexWeb.Schema.Types.Exercise

  @desc "Logic training representation"
  object :training do
    field :id, non_null(:uuid4)
    field :period, non_null(:date_range)
    field :exercises, non_null(list_of(:exercise))
  end

  input_object :create_training_input do
    field :user_id, non_null(:uuid4)
    field :period, non_null(:date_range)
    field :exercises, non_null(list_of(:create_exercise_input))
  end
end
