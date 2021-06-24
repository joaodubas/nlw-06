defmodule WabanexWeb.Schema.Types.User do
  use Absinthe.Schema.Notation

  @desc "Logic user representation"
  object :user do
    field :name, non_null(:string)
    field :email, non_null(:string)
  end
end
