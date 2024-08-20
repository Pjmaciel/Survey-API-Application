module Types
  class Mutation < Types::BaseObject
    field :create_question, mutation: Mutations::CreateQuestion
    field :update_question, mutation: Mutations::UpdateQuestion
    field :reorder_questions, mutation: Mutations::ReorderQuestions

    field :create_survey, mutation: Mutations::CreateSurvey
    field :open_survey, mutation: Mutations::OpenSurvey
    field :close_survey, mutation: Mutations::CloseSurvey

    field :submit_survey_response, mutation: Mutations::SubmitSurveyResponse
    field :answer_survey, mutation: Mutations::AnswerSurvey

    def test_field
      "Test successful"
    end

  end
end