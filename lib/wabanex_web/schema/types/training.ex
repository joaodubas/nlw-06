defmodule WabanexWeb.Schema.Types.Training do
  use Absinthe.Schema.Notation

  @desc "Logic training representation"
  object :training do
    field :id, non_null(:uuid4)
    field :start_date, non_null(:string)
    field :end_date, :string
  end

  input_object :create_training_input do
    field :user_id, non_null(:uuid4)
    field :start_date, non_null(:string)
    field :end_date, :string
  end
end
