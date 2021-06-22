defmodule Wabanex.User do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string

    timestamps()
  end
end
