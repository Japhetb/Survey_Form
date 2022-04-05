defmodule SurveForm.Form_survey.Survey do
  use Ecto.Schema
  import Ecto.Changeset

  schema "surveys" do
    field :comments, :string
    field :course, :string
    field :email, :string
    field :name, :string
    field :regno, :string
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(survey, attrs) do
    survey
    |> cast(attrs, [:name, :email, :regno, :course, :year, :comments])
    |> validate_required([:name, :email, :regno, :course, :year, :comments])
  end
end
