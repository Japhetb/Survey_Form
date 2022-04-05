defmodule SurveFormWeb.SurveyView do
  use SurveFormWeb, :view
  alias SurveFormWeb.SurveyView

  def render("index.json", %{surveys: surveys}) do
    %{data: render_many(surveys, SurveyView, "survey.json")}
  end

  def render("show.json", %{survey: survey}) do
    %{data: render_one(survey, SurveyView, "survey.json")}
  end

  def render("survey.json", %{survey: survey}) do
    %{
      id: survey.id,
      name: survey.name,
      email: survey.email,
      regno: survey.regno,
      course: survey.course,
      year: survey.year,
      comments: survey.comments
    }
  end
end
