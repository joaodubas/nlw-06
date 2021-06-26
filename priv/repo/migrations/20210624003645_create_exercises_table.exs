defmodule Wabanex.Repo.Migrations.CreateExercisesTable do
  use Ecto.Migration

  def change do
    create table(:exercises) do
      add :name, :string, null: false
      add :video_url, :string
      add :protocol_description, :string, null: false
      add :repetitions, :string, null: false
      add :training_id, references(:trainings), null: false

      timestamps()
    end
  end
end
