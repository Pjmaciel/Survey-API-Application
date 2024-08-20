# app/graphql/mutations/open_survey.rb
module Mutations
  class OpenSurvey < Mutations::BaseMutation
    argument :id, ID, required: true

    type Types::Survey

    def resolve(id:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authorized" unless user.coordinator?

      survey = Survey.find(id)
      raise GraphQL::ExecutionError, "Survey is already open" if survey.open?

      survey.update!(status: 'open')
      survey
    end
  end
end
