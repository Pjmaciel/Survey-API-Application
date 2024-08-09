module Types
  class Mutation < Types::BaseObject
    field :create_survey, mutation: Mutations::CreateSurvey
    # Adicione outras mutations aqui
  end
end