defmodule Wabanex.Repo.Migrations.AlterTrainingsAddPeriod do
  use Ecto.Migration

  def up do
    alter table(:trainings) do
      add :period, :daterange
    end

    execute("""
      update trainings set
        period=daterange(start_date, end_date, '[)')
        , updated_at=date_trunc('second', current_timestamp::timestamp)
    """)

    alter table(:trainings) do
      remove :start_date
      remove :end_date
      modify :period, :daterange, null: false
    end

    create constraint(:trainings, :non_overlap_period,
             exclude: "gist (user_id WITH =, period with &&)"
           )
  end

  def down do
    alter table(:trainings) do
      add :start_date, :date
      add :end_date, :date
    end

    execute("""
      update trainings set
        start_date=lower(period)
        , end_date=upper(period)
        , update_at=date_trunc('second', current_timestamp::timestamp)
    """)

    drop constraint(:trainings, :non_overlap_period)

    alter table(:trainings) do
      remove :period
      modify :start_date, :date, null: false
    end
  end
end
