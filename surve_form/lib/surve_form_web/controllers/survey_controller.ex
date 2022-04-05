defmodule SurveFormWeb.SurveyController do
  use SurveFormWeb, :controller

  alias SurveForm.Form_survey
  alias SurveForm.Form_survey.Survey

  action_fallback SurveFormWeb.FallbackController

  def index(conn, _params) do
    surveys = Form_survey.list_surveys()
    render(conn, "index.json", surveys: surveys)
  end

  def create(conn, %{"survey" => survey_params}) do
    with {:ok, %Survey{} = survey} <- Form_survey.create_survey(survey_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.survey_path(conn, :show, survey))
      |> render("show.json", survey: survey)
    end
  end

  def show(conn, %{"id" => id}) do
    survey = Form_survey.get_survey!(id)
    render(conn, "show.json", survey: survey)
  end

  def update(conn, %{"id" => id, "survey" => survey_params}) do
    survey = Form_survey.get_survey!(id)

    with {:ok, %Survey{} = survey} <- Form_survey.update_survey(survey, survey_params) do
      render(conn, "show.json", survey: survey)
    end
  end

  def delete(conn, %{"id" => id}) do
    survey = Form_survey.get_survey!(id)

    with {:ok, %Survey{}} <- Form_survey.delete_survey(survey) do
      send_resp(conn, :no_content, "")
    end
  end
end
