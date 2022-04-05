defmodule SurveForm.Form_surveyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SurveForm.Form_survey` context.
  """

  @doc """
  Generate a survey.
  """
  def survey_fixture(attrs \\ %{}) do
    {:ok, survey} =
      attrs
      |> Enum.into(%{
        comments: "some comments",
        course: "some course",
        email: "some email",
        name: "some name",
        regno: "some regno",
        year: 42
      })
      |> SurveForm.Form_survey.create_survey()

    survey
  end
end
