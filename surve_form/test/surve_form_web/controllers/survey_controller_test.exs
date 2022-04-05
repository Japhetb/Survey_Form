defmodule SurveFormWeb.SurveyControllerTest do
  use SurveFormWeb.ConnCase

  import SurveForm.Form_surveyFixtures

  alias SurveForm.Form_survey.Survey

  @create_attrs %{
    comments: "some comments",
    course: "some course",
    email: "some email",
    name: "some name",
    regno: "some regno",
    year: 42
  }
  @update_attrs %{
    comments: "some updated comments",
    course: "some updated course",
    email: "some updated email",
    name: "some updated name",
    regno: "some updated regno",
    year: 43
  }
  @invalid_attrs %{comments: nil, course: nil, email: nil, name: nil, regno: nil, year: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all surveys", %{conn: conn} do
      conn = get(conn, Routes.survey_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create survey" do
    test "renders survey when data is valid", %{conn: conn} do
      conn = post(conn, Routes.survey_path(conn, :create), survey: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.survey_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "comments" => "some comments",
               "course" => "some course",
               "email" => "some email",
               "name" => "some name",
               "regno" => "some regno",
               "year" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.survey_path(conn, :create), survey: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update survey" do
    setup [:create_survey]

    test "renders survey when data is valid", %{conn: conn, survey: %Survey{id: id} = survey} do
      conn = put(conn, Routes.survey_path(conn, :update, survey), survey: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.survey_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "comments" => "some updated comments",
               "course" => "some updated course",
               "email" => "some updated email",
               "name" => "some updated name",
               "regno" => "some updated regno",
               "year" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, survey: survey} do
      conn = put(conn, Routes.survey_path(conn, :update, survey), survey: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete survey" do
    setup [:create_survey]

    test "deletes chosen survey", %{conn: conn, survey: survey} do
      conn = delete(conn, Routes.survey_path(conn, :delete, survey))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.survey_path(conn, :show, survey))
      end
    end
  end

  defp create_survey(_) do
    survey = survey_fixture()
    %{survey: survey}
  end
end
