# app/graphql/mutations/close_survey.rb
module Mutations
  class CloseSurvey < Mutations::BaseMutation
    argument :id, ID, required: true

    type Types::Survey

    def resolve(id:)
      user = context[:current_user]
      survey = Survey.find(id)

      # Verifica se o usuário é um coordenador
      raise GraphQL::ExecutionError, "Not authorized" unless user.coordinator?

      # Verifica se a pesquisa já está fechada
      raise GraphQL::ExecutionError, "Survey is already closed" if survey.closed?

      # Atualiza o status da pesquisa para "closed"
      survey.update!(status: 'closed')
      survey
    end
  end
end
