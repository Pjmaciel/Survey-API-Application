module Types
  class Mutation < Types::BaseObject
    field :create_survey, mutation: Mutations::CreateSurvey
    field :answer_survey, mutation: Mutations::AnswerSurvey
  end
end