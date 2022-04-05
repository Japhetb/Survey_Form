defmodule SurveForm.Repo.Migrations.CreateSurveys do
  use Ecto.Migration

  def change do
    create table(:surveys) do
      add :name, :string
      add :email, :string
      add :regno, :string
      add :course, :string
      add :year, :integer
      add :comments, :string

      timestamps()
    end
  end
end
