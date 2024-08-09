module Types
  class Mutation < Types::BaseObject
    field :create_question, mutation: Mutations::CreateQuestion
    field :update_question, mutation: Mutations::UpdateQuestion
    field :delete_question, mutation: Mutations::DeleteQuestion
    field :reorder_questions, mutation: Mutations::ReorderQuestions
    field :open_survey, mutation: Mutations::OpenSurvey
    field :close_survey, mutation: Mutations::CloseSurvey
  end
end