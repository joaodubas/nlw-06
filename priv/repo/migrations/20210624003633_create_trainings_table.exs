defmodule Wabanex.Repo.Migrations.CreateTrainingsTable do
  use Ecto.Migration

  def change do
    create table(:trainings) do
      add :start_date, :date, null: false
      add :end_date, :date
      add :user_id, references(:users), null: false

      timestamps()
    end
  end
end
