defmodule SurveForm.Form_surveyTest do
  use SurveForm.DataCase

  alias SurveForm.Form_survey

  describe "surveys" do
    alias SurveForm.Form_survey.Survey

    import SurveForm.Form_surveyFixtures

    @invalid_attrs %{comments: nil, course: nil, email: nil, name: nil, regno: nil, year: nil}

    test "list_surveys/0 returns all surveys" do
      survey = survey_fixture()
      assert Form_survey.list_surveys() == [survey]
    end

    test "get_survey!/1 returns the survey with given id" do
      survey = survey_fixture()
      assert Form_survey.get_survey!(survey.id) == survey
    end

    test "create_survey/1 with valid data creates a survey" do
      valid_attrs = %{comments: "some comments", course: "some course", email: "some email", name: "some name", regno: "some regno", year: 42}

      assert {:ok, %Survey{} = survey} = Form_survey.create_survey(valid_attrs)
      assert survey.comments == "some comments"
      assert survey.course == "some course"
      assert survey.email == "some email"
      assert survey.name == "some name"
      assert survey.regno == "some regno"
      assert survey.year == 42
    end

    test "create_survey/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Form_survey.create_survey(@invalid_attrs)
    end

    test "update_survey/2 with valid data updates the survey" do
      survey = survey_fixture()
      update_attrs = %{comments: "some updated comments", course: "some updated course", email: "some updated email", name: "some updated name", regno: "some updated regno", year: 43}

      assert {:ok, %Survey{} = survey} = Form_survey.update_survey(survey, update_attrs)
      assert survey.comments == "some updated comments"
      assert survey.course == "some updated course"
      assert survey.email == "some updated email"
      assert survey.name == "some updated name"
      assert survey.regno == "some updated regno"
      assert survey.year == 43
    end

    test "update_survey/2 with invalid data returns error changeset" do
      survey = survey_fixture()
      assert {:error, %Ecto.Changeset{}} = Form_survey.update_survey(survey, @invalid_attrs)
      assert survey == Form_survey.get_survey!(survey.id)
    end

    test "delete_survey/1 deletes the survey" do
      survey = survey_fixture()
      assert {:ok, %Survey{}} = Form_survey.delete_survey(survey)
      assert_raise Ecto.NoResultsError, fn -> Form_survey.get_survey!(survey.id) end
    end

    test "change_survey/1 returns a survey changeset" do
      survey = survey_fixture()
      assert %Ecto.Changeset{} = Form_survey.change_survey(survey)
    end
  end
end
